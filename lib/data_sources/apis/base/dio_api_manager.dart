import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

// Ensure these imports match your project structure
import 'package:crashid/core/service/internet_connectivity.dart';
import 'package:crashid/data_sources/apis/api_keys.dart';
import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/utils/logout/app_logout.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';

class DioApiManager {
  DioApiManager();
  
  final _performanceInterceptor = DioFirebasePerformanceInterceptor();

  // Getters for Dio instances
  Dio get dio => _getDioInstance(baseUrl: ApiUrls.baseUrl, useAuth: true);
  Dio get dioUnauthorized => _getDioInstance(baseUrl: ApiUrls.baseUrl, useAuth: false);

  Dio _getDioInstance({required String baseUrl, bool useAuth = true}) {
    final dioInstance = DioOptions.dioInstance(DioOptions());

    dioInstance.options.baseUrl = baseUrl;
    
    // Clear interceptors to prevent duplicate stacking if the instance is reused
    dioInstance.interceptors.clear();

    // 1. Add Auth or Unauthorized Interceptor
    dioInstance.interceptors.add(
      useAuth ? _queuedInterceptorsWrapper : _queuedInterceptorsWrapperUnauthorized,
    );

    // 2. Add Firebase Performance Interceptor
    dioInstance.interceptors.add(_performanceInterceptor);

    // 3. Add Built-in LogInterceptor (This guarantees you see logs)
    if (kDebugMode) {
      dioInstance.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ));
    }

    return dioInstance;
  }

  // --- INTERCEPTORS ---

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapper {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) async {
        log("🚀 REQUEST [${request.method}] => ${request.uri}");
        
        // Connectivity Check
        bool isConnected = await InternetConnectivity.checkNetworkType();
        if (!isConnected) {
          return handler.reject(
            DioException(
              requestOptions: request,
              error: "No internet connection",
              type: DioExceptionType.connectionError,
            ),
          );
        }

        await _setToken(request);
        return handler.next(request);
      },
      onResponse: (response, handler) {
        debugPrint(
          "✅ RESPONSE [${response.statusCode}] => ${response.requestOptions.path}",
        );
        debugPrint("RESPONSE BODY: ${_serializeData(response.data)}");
        return handler.next(response);
      },
      onError: _onError,
    );
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapperUnauthorized {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) {
        log("🔓 UNAUTHORIZED REQUEST [${request.method}] => ${request.uri}");
        return handler.next(request);
      },
      onResponse: (response, handler) {
        debugPrint(
          "✅ UNAUTHORIZED RESPONSE [${response.statusCode}] => ${response.requestOptions.path}",
        );
        debugPrint("UNAUTHORIZED RESPONSE BODY: ${_serializeData(response.data)}");
        return handler.next(response);
      },
      onError: _onError,
    );
  }

  // --- HELPERS ---

  Future<void> _setToken(RequestOptions request) async {
    final token = await GetIt.I<SecureStorage>().getUserToken();
   print("token...$token");
    if (token.isNotNullOrNotEmpty) {
      if (request.headers[ApiKeys.authorization] == null) {
        request.headers[ApiKeys.authorization] = '${ApiKeys.keyBearer} $token';
      }
    }
  }

  void _onError(DioException error, ErrorInterceptorHandler handler) async {
    String errorMessage = "Something went wrong. Please try again.";
    
    debugPrint("❌ ERROR [${error.response?.statusCode}] => ${error.requestOptions.path}");
    debugPrint("ERROR BODY: ${_serializeData(error.response?.data)}");

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = "Connection timed out. Please check your internet.";
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          // Prevent logout loop on specific endpoints
          final path = error.requestOptions.path;
          if (!path.contains('invitations') && !path.contains("iap-verify")) {
            logOutNow();
          }
          errorMessage = "Session expired. Please login again.";
        } else {
          errorMessage =
              _extractApiMessage(error.response?.data) ??
              error.message ??
              "Server Error";
        }
        break;
      default:
        errorMessage = error.message ?? "An unexpected error occurred";
    }

    // Return the modified error message
    return handler.reject(
      DioException(
        requestOptions: error.requestOptions,
        message: errorMessage,
        type: error.type,
        response: error.response,
      ),
    );
  }

  String? _extractApiMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final dynamic message = data['message'] ?? data['error'] ?? data['detail'];
      if (message is String && message.trim().isNotEmpty) return message;

      final dynamic errors = data['errors'];
      if (errors is Map<String, dynamic> && errors.isNotEmpty) {
        final dynamic firstValue = errors.values.first;
        if (firstValue is List &&
            firstValue.isNotEmpty &&
            firstValue.first is String) {
          return firstValue.first as String;
        }
        if (firstValue is String && firstValue.trim().isNotEmpty) {
          return firstValue;
        }
      }
    } else if (data is String && data.trim().isNotEmpty) {
      return data;
    }
    return null;
  }

  String _serializeData(dynamic data) {
    if (data == null) return 'null';
    try {
      return data.toString();
    } catch (_) {
      return '<unserializable response>';
    }
  }

  Future<void> logOutNow() async {
    AppLogoutHelper.logout();
  }

  Future<void> clearDio() async {
    DioOptions.dio?.close(force: true);
    DioOptions.dio = null;
  }
}

// --- CONFIGURATION ---

class DioOptions extends BaseOptions {
  DioOptions()
      : super(
          connectTimeout: const Duration(seconds: 15),
          sendTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
        );

  @override
  Map<String, dynamic> get headers => {
        ApiKeys.accept: ApiKeys.applicationJson,
      };

  static Dio? dio;

  static Dio dioInstance(BaseOptions options) {
    dio ??= Dio(options);
    return dio!;
  }
}
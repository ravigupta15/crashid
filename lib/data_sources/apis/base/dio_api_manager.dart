import 'dart:convert';
import 'dart:developer';
import 'package:crashid/core/service/internet_connectivity.dart';
import 'package:crashid/data_sources/apis/api_keys.dart';
import 'package:crashid/data_sources/apis/api_urls.dart';
import 'package:crashid/data_sources/local_storage/secure_storage.dart';
import 'package:crashid/utils/extensions/extension_string.dart';
import 'package:crashid/utils/logout/app_logout.dart';
import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class DioApiManager {
  DioApiManager();

  final _performanceInterceptor = DioFirebasePerformanceInterceptor();

  Dio get dio =>
      _getDioInstance(baseUrl: ApiUrls.baseUrl, useAuth: true);

  Dio get dioUnauthorized =>
      _getDioInstance(baseUrl: ApiUrls.baseUrl, useAuth: false);

  Dio _getDioInstance({required String baseUrl, bool useAuth = true}) {
    final dioInstance = DioOptions.dioInstance(options);

    dioInstance.options.baseUrl = baseUrl;

    dioInstance.interceptors.clear();

    dioInstance.interceptors.add(
      useAuth
          ? _queuedInterceptorsWrapper
          : _queuedInterceptorsWrapperUnauthorized,
    );

    dioInstance.interceptors.addAll(interceptors);

    return dioInstance;
  }

  List<Interceptor> get interceptors {
    return [
      _performanceInterceptor,
    ];
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapper {
    return QueuedInterceptorsWrapper(
      onError: _onError,
      onRequest: (request, handler) async {
        log("REQUEST [${request.method}] => ${request.uri}");
        print("api...${request.uri}");
        print("data...${request.data}");

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
      onResponse: _onResponse,
    );
  }

  void _onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("response...${json.encode(response.data)}");

    if (response.statusCode == 401) {
      return handler.reject(
        DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Unauthorized access',
        ),
        true,
      );
    }
    return handler.next(response);
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapperUnauthorized {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) {
        log("🚀 UNAUTHORIZED REQUEST [${request.method}] => ${request.uri}");
        return handler.next(request);
      },
    );
  }

  Future<void> logOutNow() async {
    AppLogoutHelper.logout();
  }

  Future<void> _setToken(RequestOptions request) async {
    final results = await  GetIt.I<SecureStorage>().getUserToken();

    final String? token = results;
      if (token.isNotNullOrNotEmpty) {
        if (request.headers[ApiKeys.authorization] == null) {
          request.headers[ApiKeys.authorization] =
              '${ApiKeys.keyBearer} $token';
        } else {
          request.headers.remove(ApiKeys.authorization);
        }
    }
  }

  DioOptions get options => DioOptions();

  void _onError(DioException error, ErrorInterceptorHandler handler) async {
    String errorMessage = "Something went wrong. Please try again.";
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        errorMessage = "Connection timed out. Please check your internet.";
        break;
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          if (!error.requestOptions.path.contains('invitations') ||
              !error.requestOptions.path.contains("iap-verify")) {
            logOutNow();
          }
          errorMessage = error.message ?? '';
        }
        break;
      default:
        errorMessage = error.message ?? '';
    }

    return handler.reject(
      DioException(
        requestOptions: error.requestOptions,
        message: errorMessage,
        type: error.type,
        response: error.response,
      ),
    );
  }

  Future<void> clearDio() async {
    DioOptions.dio?.close(force: true);
    DioOptions.dio = null;
  }
}

class DioOptions extends BaseOptions {
  DioOptions()
    : super(
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
      );

  @override
  Map<String, dynamic> get headers => {ApiKeys.accept: ApiKeys.applicationJson};

  static Dio? dio;

  static Dio dioInstance(BaseOptions options) {
    dio ??= Dio(options);
    return dio!;
  }
}

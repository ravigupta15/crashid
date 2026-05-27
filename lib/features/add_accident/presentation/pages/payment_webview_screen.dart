import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class PaymentWebviewScreen extends StatefulWidget {
static const kPaymentUrl = "/kPaymentUrl";
static const kOnPaymentSuccess = "/kOnPaymentSuccess";
static const kOnPaymentFailure = "/kOnPaymentFailure";

  final String? paymentUrl;
//   final String? orderId;
  final VoidCallback? onPaymentFailure;

  static Future<String?> open(
    BuildContext context, {
    String? paymentUrl,
    VoidCallback? onPaymentFailure,
  }) {
    return context.push<String?>(AppRoutesPath.paymentWebViewScreen, extra: {
      kPaymentUrl: paymentUrl,
      kOnPaymentFailure: onPaymentFailure
    });
  }

  const PaymentWebviewScreen({
    super.key,
    this.paymentUrl ,
    this.onPaymentFailure,
  });

  @override
  State<PaymentWebviewScreen> createState() => _PaymentWebviewScreenState();
}

class _PaymentWebviewScreenState extends State<PaymentWebviewScreen> {
  late InAppWebViewController _webViewController;
  bool _isLoading = true;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    // Additional WebView initialization if needed
  }

  String? _extractOrderIdFromUri(Uri? uri) {
    if (uri == null) return null;
    return uri.queryParameters['paypal_order_id'] ??
        uri.queryParameters['token'];
  }

  void _showLoadingIndicator() {
    context.loaderOverlay.show();
  }

  void _hideLoadingIndicator() {
    if (mounted) {
      context.loaderOverlay.hide();
    }
  }

  void _handlePaymentSuccess(Uri uri) {
    _hideLoadingIndicator();
    final orderId = _extractOrderIdFromUri(uri);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.pop(orderId);
        }
      });
    }
  }

  void _handlePaymentFailure() {
    _hideLoadingIndicator();
    widget.onPaymentFailure?.call();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
            backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: const Text('Payment'),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
          actions: [
            if (!_isLoading)
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  _webViewController.reload();
                },
              ),
          ],
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri(widget.paymentUrl  ?? ''),
              ),
              initialSettings: InAppWebViewSettings(
                useShouldOverrideUrlLoading: true,
                mediaPlaybackRequiresUserGesture: false,
                allowsInlineMediaPlayback: true,
                javaScriptEnabled: true,
                javaScriptCanOpenWindowsAutomatically: true,
                useHybridComposition: true,
              ),
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url;

                // Handle payment success URLs
                if (uri.toString().contains('success') ||
                    uri.toString().contains('payment-success') ||
                    uri.toString().contains('status=success')) {
                        print("uri....$uri");
                  _handlePaymentSuccess(uri!);
                  return NavigationActionPolicy.CANCEL;
                }

                // Handle payment failure URLs
                if (uri.toString().contains('failure') ||
                    uri.toString().contains('payment-failure') ||
                    uri.toString().contains('cancel') ||
                    uri.toString().contains('status=failed')) {
                        print("uri faield....$uri");
                  _handlePaymentFailure();
                  return NavigationActionPolicy.CANCEL;
                }

                // Allow all other URLs to load
                return NavigationActionPolicy.ALLOW;
              },
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                if (mounted) {
                  setState(() {
                    _isLoading = true;
                  });
                  _showLoadingIndicator();
                }
              },
              onLoadStop: (controller, url) {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                  _hideLoadingIndicator();
                }
              },
              onProgressChanged: (controller, progress) {
                if (mounted) {
                  setState(() {
                    _progress = progress / 100;
                  });
                }
              },
              onReceivedError: (controller, request, error) {
                if (mounted) {
                  _hideLoadingIndicator();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${error.description}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              onReceivedHttpError: (controller, request, errorResponse) {
                if (mounted) {
                  _hideLoadingIndicator();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('HTTP Error: ${errorResponse.statusCode}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              onConsoleMessage: (controller, consoleMessage) {
                debugPrint('Console message: ${consoleMessage.message}');
              },
            ),
            if (_isLoading)
              LinearProgressIndicator(
                value: _progress,
                minHeight: 4,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

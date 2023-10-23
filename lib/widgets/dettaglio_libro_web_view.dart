import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DettaglioLibroWebView extends StatelessWidget {
  final String pageUrl;
  const DettaglioLibroWebView(this.pageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    const PlatformWebViewControllerCreationParams params = PlatformWebViewControllerCreationParams();
    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    String pageUrlHttps = pageUrl;
    if (!pageUrl.contains('https')) {
      pageUrlHttps = pageUrl.replaceFirst('http', 'https');
    }
    
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(pageUrlHttps)) {
              debugPrint('blocking navigation to ${request.url.replaceFirst('http', 'https')}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(pageUrlHttps));

    return WebViewWidget(controller: controller);
  }

}
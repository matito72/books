import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DettaglioLibroWebView extends StatelessWidget {
  final String _pageUrl;
  const DettaglioLibroWebView(this._pageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    const PlatformWebViewControllerCreationParams params = PlatformWebViewControllerCreationParams();
    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    String pageUrlHttps = _pageUrl;
    if (!_pageUrl.contains('https')) {
      pageUrlHttps = _pageUrl.replaceFirst('http', 'https');
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
            controller.runJavaScript('''
              document.querySelector('[id=volume-left]').remove();
              document.querySelector('[id=search_bar]').remove();
              document.querySelector('[id=gba]').remove();
              document.getElementsByClassName("gb_rd")[0].remove();
              document.getElementsByTagName('header')[0].style.display='none';
              document.getElementsByTagName('footer')[0].style.display='none';
              document.getElementsByClassName('gb_Tf gb_if')[0].remove();
            ''')
          .then((value) => debugPrint('Page finished loading Javascript'))
          .catchError((onError) => debugPrint('$onError'));
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
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SearchBrowser extends StatefulWidget {
  @override
  _SearchBrowserState createState() => _SearchBrowserState();
}

class _SearchBrowserState extends State<SearchBrowser> {
  late final WebViewController _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.google.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Browser"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if (await _webViewController.canGoBack()) {
                _webViewController.goBack();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if (await _webViewController.canGoForward()) {
                _webViewController.goForward();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    home: SearchBrowser(),
  ));
}
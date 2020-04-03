import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quarantimes_app/src/pages/home.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  final String url;
  const ArticleWebView(this.url);

  @override
  _ArticleWebViewState createState() => _ArticleWebViewState(this.url);
}

class _ArticleWebViewState extends State<ArticleWebView> {
  final String url;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  _ArticleWebViewState(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Quarantimes',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'OldeEnglish',
            fontWeight: FontWeight.w600,
            fontSize: 35,
            letterSpacing: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          },
        ),
      ),
      body: WebView(
        initialUrl: this.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quarantimes_app/src/models/Article.dart';
import 'package:quarantimes_app/src/pages/webview_page.dart';

class NewsHeader extends StatelessWidget {
  final Article article;

  const NewsHeader(this.article);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(top: 50, left: 15, right: 15),
        width: 320,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xCC000000),
              const Color(0xCC000000),
              const Color(0xCC000000),
              const Color(0xCC000000),
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(article.urlToImage),
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10, right: 15),
              child: Text(
                article.title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Merriweather',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(0.1, 0.1),
                      blurRadius: 1.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleWebView(article.url)),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:quarantimes_app/src/models/Article.dart';
import 'package:quarantimes_app/src/pages/webview_page.dart';

class NewsBanner extends StatelessWidget {
  final Article article;

  const NewsBanner(this.article);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 15, top: 10),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: 130,
                    height: 110,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(article.urlToImage),
                      ),
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 5),
                    child: Container(
                      width: 225,
                      height: 110,
                      //color: Colors.blueAccent,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 82,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    article.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Merriweather',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  article.source,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Lato',
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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

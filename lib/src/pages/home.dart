import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quarantimes_app/src/models/Article.dart';
import 'package:quarantimes_app/src/models/api_response.dart';
import 'package:quarantimes_app/src/services/article_service.dart';
import 'package:quarantimes_app/src/widgets/custom_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ArticleService get service => GetIt.I<ArticleService>();
  APIResponse<List<Article>> _apiResponseHeaders;
  APIResponse<List<Article>> _apiResponseBanner;
  bool _isLoading = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    _fetchHeadlines();
    _fetchBanners();
    super.initState();
  }

  //fetch english articles
  _fetchHeadlines() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseHeaders = await service.getHeadlines();

    setState(() {
      _isLoading = false;
    });
  }

  //fetch spanish articles
  _fetchBanners() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponseBanner = await service.getArticles();

    setState(() {
      _isLoading = false;
    });
  }

  Future<Null> refresh() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _fetchHeadlines();
      _fetchBanners();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              Container(
                width: 500,
                child: Padding(
                  padding: EdgeInsets.only(top: 50, left: 15, bottom: 15),
                  child: Text(
                    'The Quarantimes',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'OldeEnglish',
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                        letterSpacing: 0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Container(
                  height: 350,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 5),
                        child: Text(
                          'Fresh news',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Lato',
                          ),
                        ),
                      ),
                      Builder(builder: (_) {
                        if (_isLoading) {
                          return CircularProgressIndicator();
                        }

                        if (_apiResponseHeaders.error) {
                          return Center(
                              child: Text(_apiResponseHeaders.errorMessage));
                        }

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: _apiResponseHeaders.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return NewsHeader(_apiResponseHeaders.data[index]);
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Container(
                width: 500,
                height: 60,
                child: Padding(
                  padding: EdgeInsets.only(top: 15, left: 15, bottom: 10),
                  child: Text(
                    'Newsletters',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ),
              Builder(builder: (_) {
                List<NewsBanner> list = [];

                if (_isLoading) {
                  return CircularProgressIndicator();
                }

                if (_apiResponseBanner.error) {
                  return Center(child: Text(_apiResponseBanner.errorMessage));
                }

                for (var i = 0; i < _apiResponseBanner.data.length; i++) {
                  list.add(NewsBanner(_apiResponseBanner.data[i]));
                }
                return Column(children: list);
              }),
              Container(
                  width: 250,
                  height: 100,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Developed by Alejandro Solano, March 2020. Using newsapi.org',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Lato',
                      ),
                    ),
                  )),
            ],
          ),
        ),
        onRefresh: refresh,
      ),
    );
  }
}

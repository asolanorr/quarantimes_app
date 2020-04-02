import 'package:quarantimes_app/src/models/Article.dart';
import 'package:quarantimes_app/src/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ArticleService {
  Future<APIResponse<List<Article>>> getHeadlines () {
    
    return http.get('http://newsapi.org/v2/top-headlines?language=en&sources=google-news&q=coronavirus&apiKey=c6318bce508b408994ed10c0526561ac')
    .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final articles = <Article>[];
        for (var item in jsonData['articles']) {
          final article = Article(
            source: 'Desconocido',
            author: item['author'],
            title: item['title'],
            description: item['description'],
            url: item['url'],
            urlToImage: item['urlToImage'],
            publishedAt: item['publishedAt'],
            content: item['content']
          );
          if(item['urlToImage'] != null) {
            articles.add(article);
          }
        }
        return APIResponse<List<Article>>(
          data: articles,
        );
      }
      return APIResponse<List<Article>>(error: true, errorMessage: 'An error occurred');
    })
    .catchError((_) => APIResponse<List<Article>>(error: true, errorMessage: 'An error occurred'));
  }

    Future<APIResponse<List<Article>>> getArticles () {
    
    return http.get('http://newsapi.org/v2/everything?language=es&q=coronavirus&apiKey=c6318bce508b408994ed10c0526561ac')
    .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final banners = <Article>[];
        for (var item in jsonData['articles']) {
          final article = Article(
            source: item['author'],
            author: item['author'],
            title: item['title'],
            description: item['description'],
            url: item['url'],
            urlToImage: item['urlToImage'],
            publishedAt: item['publishedAt'],
            content: item['content']
          );
          if(item['urlToImage'] != null) {
            banners.add(article);
          }
        }
        return APIResponse<List<Article>>(
          data: banners,
        );
      }
      return APIResponse<List<Article>>(error: true, errorMessage: 'An error occurred');
    })
    .catchError((_) => APIResponse<List<Article>>(error: true, errorMessage: 'An error occurred'));
  }
}
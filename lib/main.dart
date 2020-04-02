import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quarantimes_app/src/pages/home.dart';
import 'package:quarantimes_app/src/services/article_service.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => ArticleService());
}

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}

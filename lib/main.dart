import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/bookmarked_model.dart';
import 'package:news_app/views/home.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
String Saved_Articles='Saved_Articles';

 void main() async {

   WidgetsFlutterBinding.ensureInitialized();
   final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
   Hive.init(appDocumentDirectory.path);
   Hive.registerAdapter(SavedArticleModelAdapter());
   await Hive.openBox(Saved_Articles);
   runApp(MyApp());
   //List<ArticleModel> bookmarkedArticles = new List<ArticleModel>();

 }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:Home(),
    );
  }
}



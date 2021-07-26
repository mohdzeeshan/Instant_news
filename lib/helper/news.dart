import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/main.dart';
import 'package:news_app/models/article_model.dart';

final String apiKey = '43b4c46719a04d1497429af3f7d42599';

Future getPosts(String url) async {
  var response = await http.get(Uri.parse(url));
  var jsonData = jsonDecode(response.body);
  Hive.box(Articles).put('articles', jsonData);
  var cachedjsonData = Hive.box(Articles).get('articles');
  return cachedjsonData;
}

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey";
    var jsonData = await getPosts(url);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String Category) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&category=$Category&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=43b4c46719a04d1497429af3f7d42599";

    var jsonData = await getPosts(url);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }
      });
    }
  }
}

class SearchNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String search) async {
    String url =
        "https://newsapi.org/v2/everything?q={$search}&sortBy=popularity&apiKey=$apiKey";

    var jsonData = await getPosts(url);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }
      });
    }
  }
}

class NewsSourceClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String sourceID) async {
    String url =
        "https://newsapi.org/v2/everything?sources=$sourceID&apiKey=$apiKey";

    var jsonData = await getPosts(url);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }
      });
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart' as http;
final String apiKey ='43b4c46719a04d1497429af3f7d42599';
class News {
  List<ArticleModel> news =[];
  Future<void> getNews() async{
    String url ="https://newsapi.org/v2/top-headlines?country=in&apiKey=$apiKey";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }

      });
    }
  }
}

class CategoryNewsClass {

  List<ArticleModel> news =[];
  Future<void> getNews(String Category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=in&category=$Category&excludeDomains=stackoverflow.com&sortBy=publishedAt&language=en&apiKey=43b4c46719a04d1497429af3f7d42599";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }

      });
    }
  }
}

  class SearchNewsClass{
  
    List<ArticleModel> news =[];
    Future<void> getNews(String search) async{
      String url ="https://newsapi.org/v2/everything?q={$search}&apiKey=$apiKey";

      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      if(jsonData['status'] == "ok"){
        jsonData["articles"].forEach((element){

          if(element['urlToImage'] != null && element['description'] != null){
            ArticleModel articleModel = ArticleModel.fromJson(element);
            news.add(articleModel);
          }
        });

      }
    }
}

class NewsSourceClass{

  List<ArticleModel> news =[];
  Future<void> getNews(String sourceID) async {
    String url = "https://newsapi.org/v2/everything?sources=$sourceID&apiKey=$apiKey";

    try{
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      Hive.box(Saved_Articles).put('articles', jsonData);

      //jsonData["articles"].forEach((element){
      Hive.box(Saved_Articles).get('articles').forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel.fromJson(element);
          news.add(articleModel);
        }
      });
    }
  }
  catch(SocketException){
      print('No Internet');

      Hive.box(Saved_Articles).get('articles').forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            source: element['source']['name'],
            sourceID: element['source']['id'],
            content: element["content"],
          );
          news.add(articleModel);
        }
      });


  }

  }
}
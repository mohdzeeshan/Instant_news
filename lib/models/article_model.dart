import 'package:hive/hive.dart';
part 'article_model.g.dart';

@HiveType(typeId: 1)
class ArticleModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String url;
  @HiveField(3)
  String urlToImage;
  @HiveField(4)
  String content;
  @HiveField(5)
  String source;
  @HiveField(6)
  bool bookmarked;
  @HiveField(7)
  String date;

  ArticleModel({
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
    this.source,
    this.date,
    this.bookmarked = false,

  });

  factory ArticleModel.fromJson(Map<String, dynamic> element) {
    return ArticleModel(
      title: element['title'],
      description: element["description"],
      url: element["url"],
      urlToImage: element["urlToImage"],
      source: element['source']['name'],
      content: element["content"],
      date: element["publishedAt"]
    );
  }
}

import 'package:hive/hive.dart';
part 'bookmarked_model.g.dart';
@HiveType(typeId: 0)
class SavedArticleModel{
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
  //String sourceID;

  SavedArticleModel({this.title, this.description,this.url, this.urlToImage, this.content, this.source });
}
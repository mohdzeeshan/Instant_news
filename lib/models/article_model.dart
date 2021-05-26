class ArticleModel{
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  String source;
  String sourceID;

  ArticleModel({this.sourceID, this.title, this.description,this.url, this.urlToImage, this.content, this.source });

  factory ArticleModel.fromJson(Map<String, dynamic> element) {
    return ArticleModel(title: element['title'],
      description: element["description"],
      url: element["url"],
      urlToImage: element["urlToImage"],
      source: element['source']['name'],
      sourceID: element['source']['id'],
      content: element["content"],);
  }

}

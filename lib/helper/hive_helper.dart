import 'package:hive/hive.dart';
import 'package:news_app/models/article_model.dart';

Future addBookmarkArticleToLocalDB(ArticleModel articleModel) async {
  await Hive.openBox('bookmarkArticles');
  Box box = Hive.box('bookmarkArticles');
  List<ArticleModel> articles = await box.get('articles');
  if (articles == null) {
    await box.put('articles', [articleModel]);
  } else {
    articles.add(articleModel);
    await box.put('articles', articles);
  }
}

Future<List<ArticleModel>> getBookmarkArticleToLocalDB() async {
  List articles;
  await Hive.openBox('bookmarkArticles');
  Box box = Hive.box('bookmarkArticles');
  articles = await box.get('articles');
  return List<ArticleModel>.from(articles) ?? [];
}

Future deleteBookmarkArticleToLocalDB(ArticleModel articleModel) async {
  await Hive.openBox('bookmarkArticles');
  Box box = Hive.box('bookmarkArticles');
  List<ArticleModel> articles = await box.get('articles');
  if (articles != null) {
    for (int i = 0; i < articles.length; i++) {
      if (articles[i].title == articleModel.title) {
        articles.removeAt(i);
      }
    }
    await box.put('articles', articles);
  }
}

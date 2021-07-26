import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/hive_helper.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/Blog_View.dart';

class SavedView extends StatefulWidget {
  @override
  _SavedViewState createState() => _SavedViewState();
}

bool _loading = true;

class _SavedViewState extends State<SavedView> {
  List<ArticleModel> articles = [];
  void getArticles() async {
    try {
      articles = await getBookmarkArticleToLocalDB();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Bookmarked"),
            Text(
              " News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ListView.builder(
                          itemCount: articles.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                              sourceName: articles[index].source,
                              //time: articles[index].date,
                              isBookmarkView: true,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/Blog_View.dart';

import 'home.dart';

class SearchView extends StatefulWidget {
  String searchedQuery = '';
  bool loading;

  SearchView({@required this.searchedQuery, this.loading});

  @override
  _SearchViewState createState() => _SearchViewState();
}

List<ArticleModel> articles = new List<ArticleModel>();



class _SearchViewState extends State<SearchView> {
  void initState() {
    print(widget.searchedQuery);
    // TODO: implement initState
    super.initState();
    getNews();
  }

  getNews() async {
    SearchNewsClass newsClass = SearchNewsClass();
    await newsClass.getNews(widget.searchedQuery);
    articles = newsClass.news;
    setState(() {
      widget.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Instant"),
            Text(
              "News",
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: widget.loading
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
                              time: articles[index].date,
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

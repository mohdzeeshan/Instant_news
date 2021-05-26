import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/hive_helper.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/search_view.dart';

import 'home.dart';

class SavedView extends StatefulWidget {
  @override
  _SavedViewState createState() => _SavedViewState();
}

bool _loading = false;

class _SavedViewState extends State<SavedView> {
  void test() async {
    List<ArticleModel> x = await getBookmarkArticleToLocalDB();
    print(x.length);
  }

  @override
  void initState() {
    test();
    super.initState();
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
                    CupertinoSearchTextField(
                      placeholder: 'Search Anything',
                      onSubmitted: (value) async {
                        searchQuery = value;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchView()));
                      },
                    ),

                    ///Blogs
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/categori_model.dart';
import 'package:news_app/views/Blog_View.dart';
import 'package:news_app/views/saved_article_view.dart';
import 'package:news_app/views/search_view.dart';
import 'package:news_app/views/settings1.dart';
import 'Category_Tile_view.dart';

String searchQuery = '';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;
  bool _loading1 = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  Future<void> getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int itemCount;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            RichText(
              text: TextSpan(
                text: "Instant",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: "News",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            IconButton(
                icon: Icon(
                  Icons.bookmarks,
                ),
                highlightColor: Colors.blue,
                iconSize: 25,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SavedView()));
                }),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => settingsUI()));
              },
              icon: Icon(Icons.settings),
              highlightColor: Colors.blue,
              iconSize: 25,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : RefreshIndicator(
              onRefresh: getNews,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: <Widget>[
                      ///Categories
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        height: 70,
                        child: ListView.builder(
                            itemCount: categories.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CategoryTile(
                                imageUrl: categories[index].imageUrl,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),

                      CupertinoSearchTextField(
                        placeholder: 'Search Anything',
                        onSubmitted: (value) async {
                          setState(() {
                            _loading1 = true;
                          });
                          searchQuery = value;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchView(
                                        loading: _loading1,
                                        searchedQuery: searchQuery,
                                      )));
                        },
                      ),

                      ///Blogs
                      Container(
                        padding: EdgeInsets.only(top: 10),
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
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

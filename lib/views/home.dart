import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/main.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/bookmarked_model.dart';
import 'package:news_app/models/categori_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/category_news.dart';
import 'package:news_app/views/saved_article_view.dart';
import 'package:news_app/views/search_view.dart';
import 'package:news_app/views/settings.dart';
import 'package:news_app/views/source_view.dart';
import 'package:share/share.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:hive/hive.dart';

String searchQuery = '';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;


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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(flex: 2,),
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
            IconButton(icon: Icon(Icons.download_done_outlined),highlightColor: Colors.blue,
                iconSize: 25, onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SavedView()));

                }),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
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
                          searchQuery = value;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchView(
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
                                sourceID: articles[index].sourceID,
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

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;

  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 120,
                    height: 60,
                    fit: BoxFit.cover)),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(
                categoryName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, sourceName, sourceID;

  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url,
      @required this.sourceName, this.sourceID,
      });

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        if (sourceID != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SourceView(
                        sourceID: sourceID,
                      )));
        } else
          print('errrrr');
      };

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        //margin: EdgeInsets.only(bottom: 2),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)),
              Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                desc,
                style: TextStyle(color: Colors.black54),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Source: $sourceName',
                      style: DefaultTextStyle.of(context).style,
                      recognizer: _gestureRecognizer,
                    ),
                  ),
                  //Text('Source: $sourceName'),
                  Spacer(),
                  IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(url);
                      }),
                  Spacer(),
                  FavoriteButton(
                    iconSize: 40,
                    iconColor: Colors.blue,
                    isFavorite: false,
                    valueChanged: (_isFavourite) {
                      if(_isFavourite){
                      Hive.box(Saved_Articles).put('title', title);}
                      else Hive.box(Saved_Articles).delete('title');

                      print(Hive.box(Saved_Articles).get('title'));

                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
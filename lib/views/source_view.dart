import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/data.dart';
import 'package:news_app/helper/news.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/categori_model.dart';
import 'home.dart';
class SourceView extends StatefulWidget {
  String sourceID='';
  SourceView({this.sourceID});

  @override
  _SourceViewState createState() => _SourceViewState();

}
List<ArticleModel> articles = new List<ArticleModel>();
List<CategoryModel> categories = new List<CategoryModel>();
bool _loading = true;


class _SourceViewState extends State<SourceView> {

  void initState() {
    print(widget.sourceID);
    // TODO: implement initState
    super.initState();
;
    getNews();
  }
  getNews() async {
    NewsSourceClass newsClass =NewsSourceClass();
    await newsClass.getNews(widget.sourceID);
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
            Text("Instant"),
            Text("News", style: TextStyle(
                color: Colors.blue
            ),)
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ): SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[

              CupertinoSearchTextField(
                placeholder:'Search Anything',
                onSubmitted: (value) async {
                  searchQuery =value;
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SourceView()));
                },
              ),

              ///Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
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





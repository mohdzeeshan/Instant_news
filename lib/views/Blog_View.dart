import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/hive_helper.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/source_view.dart';
import 'package:share/share.dart';

class BlogTile extends StatefulWidget {
  final String imageUrl, title, desc, url, sourceName, sourceID,time;
  final bool isBookmarkView;
  bool isBookmarked;
  DateTime d;


  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
    this.time,
    @required this.sourceName,
    this.sourceID,
    this.isBookmarkView = false,
  });


  @override
  _BlogTileState createState() => _BlogTileState();
}

class _BlogTileState extends State<BlogTile> {

   convert(){
    widget.d= DateTime.parse(widget.time);
  }
  String convertMonth(int i){
     if(i==1){return 'Jan';}
     else if(i==2){return 'Feb';}
     else if(i==3){return 'Mar';}
     else if(i==4){return 'April';}
     else if(i==5){return 'May';}
     else if(i==6){return 'June';}
     else if(i==7){return 'July';}
     else if(i==8){return 'Aug';}
     else if(i==9){return 'Sept';}
     else if(i==10){return 'Oct';}
     else if(i==11){return 'Nov';}
     else {return 'Dec';}
     }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        if (widget.sourceID != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SourceView(
                        sourceID: widget.sourceID,
                      )));
        }
      };

    return FutureBuilder(
      future: convert(),
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleView(
                          blogUrl: widget.url,
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
                      child: Image.network(widget.imageUrl)),
                  Text(
                    widget.title,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.desc,
                    style: TextStyle(color: Colors.black54),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${widget.sourceName}',
                          style: DefaultTextStyle.of(context).style,
                          recognizer: _gestureRecognizer,
                        ),
                      ),
                      Spacer(),
                      Text("${widget.d.day} ${convertMonth(widget.d.month)}"),
                      Spacer(),
                      IconButton(
                          icon: Icon(Icons.share),
                          onPressed: () {
                            Share.share(widget.url);
                          }),

                      Spacer(),
                      widget.isBookmarkView?
                          IconButton(icon: Icon(Icons.delete), onPressed: (){
                              deleteBookmarkArticleToLocalDB(ArticleModel(
                                title: widget.title,
                                url: widget.url,
                                urlToImage: widget.imageUrl,
                                description: widget.desc,
                                source: widget.sourceName,
                              ));

                          })
                          :FavoriteButton(
                        iconSize: 40,
                        iconColor: Colors.blue,
                        isFavorite: widget.isBookmarked,
                        valueChanged: (_isFavourite) {
                          if (_isFavourite) {
                            widget.isBookmarked == true;
                            addBookmarkArticleToLocalDB(ArticleModel(
                              title: widget.title,
                              url: widget.url,
                              urlToImage: widget.imageUrl,
                              description: widget.desc,
                              source: widget.sourceName,
                            ));
                          } else {
                            deleteBookmarkArticleToLocalDB(ArticleModel(
                              title: widget.title,
                              url: widget.url,
                              urlToImage: widget.imageUrl,
                              description: widget.desc,
                              source: widget.sourceName,
                            ));
                          }
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
    );
  }
}
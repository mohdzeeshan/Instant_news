import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/helper/hive_helper.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/views/article_view.dart';
import 'package:news_app/views/source_view.dart';
import 'package:share/share.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, sourceName, sourceID;

  BlogTile({
    @required this.imageUrl,
    @required this.title,
    @required this.desc,
    @required this.url,
    @required this.sourceName,
    this.sourceID,
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
                      if (_isFavourite) {
                        addBookmarkArticleToLocalDB(ArticleModel(
                          title: title,
                          url: url,
                          urlToImage: imageUrl,
                          description: desc,
                          source: sourceName,
                        ));
                        print(title);
                      } else {
                        deleteBookmarkArticleToLocalDB(ArticleModel(
                          title: title,
                          url: url,
                          urlToImage: imageUrl,
                          description: desc,
                          source: sourceName,
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
}

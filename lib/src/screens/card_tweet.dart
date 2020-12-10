import 'package:flutter/material.dart';
import 'package:handy_test/src/model/tweet.dart';
import 'package:handy_test/src/model/tweet_dto.dart';
import 'package:handy_test/src/model/user.dart';
import 'package:intl/intl.dart';

class CardTweet extends StatelessWidget {
  final TweetDto tweets;

  CardTweet(this.tweets);

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    var formatterDate = new DateFormat('dd-MM-yyyy HH:mm');

    final List<Tweet> tweet = tweets.tweet;
    final List<User> user = tweets.user;

    final _itemExtent = MediaQuery.of(context).size.height * 0.40;

    return SliverFixedExtentList(
      itemExtent: _itemExtent, // I'm forcing item heights
      delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          margin: new EdgeInsets.only(top: 40.0, left: 10, right: 10),
          padding: const EdgeInsets.only(top: 5),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: new BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: new Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Stack(
            children: [
              ///
              Positioned(
                top: 0.0,
                left: 0.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              NetworkImage(user[0].profileImageUrl),
                        ),
                        title: Text(
                          user[0].name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          '@${user[0].username}',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///
              Positioned(
                top: 68.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  margin: new EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    tweet[index].text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              ///
              Positioned(
                bottom: 10.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.11,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  margin: new EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.only(top: 0),
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                "RETWEETS",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                formatter
                                    .format(tweet[index].metrics.retweetCount),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue[900],
                                  fontSize: 22,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 25),
                          ),
                          Column(
                            children: [
                              Text(
                                "FAVORITES",
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                formatter
                                    .format(tweet[index].metrics.likeCount),
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue[900],
                                  fontSize: 22,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                formatterDate
                                    .format(DateTime.parse(tweet[index].createdAt) ),
                                
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey[600],
                                  fontSize: 12,
                                ),
                              ),
                              
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        childCount: tweet.length,
      ),
    );
  }
}

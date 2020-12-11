import 'package:flutter/material.dart';
import 'package:handy_test/src/model/tweet.dart';
import 'package:handy_test/src/model/tweet_dto.dart';
import 'package:handy_test/src/screens/card_tweet.dart';
import 'package:handy_test/src/service/tweet_service.dart';
import 'package:handy_test/src/style/theme.dart' as Theme;
import 'package:intl/intl.dart';

class TweetsScreen extends StatefulWidget {
  static String tag = '/TweetsScreen';
  TweetsScreen({Key key}) : super(key: key);
  // static _TweetsScreenState of(BuildContext context) => context
  //     .ancestorStateOfType(const TypeMatcher<_TweetsScreenState>());
  static bool timeout = false;

  @override
  _TweetsScreenState createState() => _TweetsScreenState();
}

class _TweetsScreenState extends State<TweetsScreen> {
  TextEditingController editingController = TextEditingController();
  List<Tweet> tweets;
  TweetDto tweetDto;
  bool queryNull = true;
  DateTime startDate;
  DateTime endDate;
  var formatterDate1 = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildBodyBack() => Container(
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [Theme.Colors.azulLogo, Theme.Colors.white],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 2.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        );

    return Scaffold(
        body: Stack(
      children: <Widget>[
        _buildBodyBack(),
        CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text("@realDonaldTrump"),
              centerTitle: true,
            ),
          ),
          _tweetsWidget(),
        ]),
        Positioned(
            bottom: 0.2,
            right: 0.0,
            child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                width: MediaQuery.of(context).size.width * 0.60,
                color: Colors.transparent,
                margin: new EdgeInsets.only(left: 10, right: 10),
                child: Row(children: [
                  ///Container Search
                  Container(
                    color: Colors.transparent,
                    width: MediaQuery.of(context).size.width * 0.50,
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      onChanged: (value) {
                        filterSearchResults(value);
                      },
                      controller: editingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Procurar",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),

                  ///Container Calendario
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width * 0.10,
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.calendar_today,
                          color: Colors.blueGrey[800]),
                    ),
                  )
                ]))),
      ],
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(new Duration(days: 6)),
      lastDate: DateTime.now(),
    );

    if (picked != null)
      setState(() {
       // print(DateFormat("yyyy-MM-dd'T'HH:mm:sss'Z'").format(picked));

        startDate = DateTime.parse(
            DateFormat("yyyy-MM-dd").format(picked) + " " + "00:00:00");
        endDate = DateTime.parse(
            DateFormat("yyyy-MM-dd").format(picked) + " " + "23:59:00");

        // print(startDate);
        // print(endDate);
        // print(DateFormat("yyyy-MM-dd'T'HH:mm:sss'Z'").format(startDate));
      });
  }

  Widget _tweetsWidget() {
    return FutureBuilder(
      future: startDate != null && endDate != null && endDate.day < DateTime.now().day
          ? TweetService()
              .getTweetDate(
                  DateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'").format(startDate),
                  DateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'").format(endDate))
              .timeout(const Duration(seconds: 10))
              .catchError((e) {
              print(e.toString());
              TweetsScreen.timeout = true;
            })
          : TweetService()
              .getTweet()
              .timeout(const Duration(seconds: 10))
              .catchError((e) {
              print(e.toString());
              TweetsScreen.timeout = true;
            }),
      builder: (context, snapshot) {
        if (!snapshot.hasData && TweetsScreen.timeout) {
          print("!snapshot.hasData && timeout");
          return SliverToBoxAdapter(
              child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ops!",
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17)),
                          ),
                          Text("Sua conexão falhou",
                              style: TextStyle(
                                  fontFamily: 'Montserrat', fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.60,
                    height: 40.0,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue)),
                      onPressed: () {
                        print("try again");
                        setState(() {
                          TweetsScreen.timeout = false;
                        });
                      },
                      color: Theme.Colors.azulLogo,
                      textColor: Colors.black,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text("Tentar novamente",
                            style: TextStyle(fontFamily: 'Heebo')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        } else if (!snapshot.hasData) {
          print("!snapshot.hasData");
          return SliverToBoxAdapter(
              child: Container(
            alignment: Alignment.center,
            height: 200.0,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ));
        } else if (snapshot.hasData == null) {
          return SliverToBoxAdapter(
              child: Container(
            alignment: Alignment.center,
            height: 200.0,
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ));
        } else {
          if (queryNull == true) {
            print(queryNull);
            tweetDto = snapshot.data;
            tweets = tweetDto.tweet;
          } else {
            print("Campo de busca não vazio");
          }

          print(tweetDto.tweet.length);

          return CardTweet(tweetDto);
        }
      },
    );
  }

  ///Busca por palavras
  void filterSearchResults(String query) {
    List<Tweet> dummySearchList = List<Tweet>();
    dummySearchList.addAll(tweets);

    if (query.isNotEmpty) {
      List<Tweet> dummyListData = List<Tweet>();

      dummySearchList.forEach((item) {
        if (item.text.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });

      setState(() {
        queryNull = false;
        tweetDto.tweet.clear();
        tweetDto.tweet.addAll(dummyListData);
      });
    } else {
      setState(() {
        queryNull = true;
        tweetDto.tweet.clear();
      });
    }
  }
}

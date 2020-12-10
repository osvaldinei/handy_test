import 'package:flutter/material.dart';
import 'package:handy_test/src/model/tweet_dto.dart';
import 'package:handy_test/src/service/tweet_service.dart';
import 'package:handy_test/src/style/theme.dart' as Theme;

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
        ])
      ],
    ));
  }

  Widget _tweetsWidget() {
    return FutureBuilder(
      future: TweetService()
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
          final TweetDto tweetDto = snapshot.data;
        }
      },
    );
  }
}

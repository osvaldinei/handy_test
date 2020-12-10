import 'package:flutter/material.dart';
import 'package:handy_test/screens/splash_screen.dart';
import 'package:handy_test/screens/tweets_screen.dart';
import 'package:handy_test/src/style/theme.dart' as Theme;

class WellcomeScreen extends StatelessWidget {
  static String tag = '/WellcomeScreen';
  WellcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height >= 775.0
                ? MediaQuery.of(context).size.height
                : 775.0,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [Theme.Colors.azulLogo, Theme.Colors.white],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 2.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Seja bem-vindo\nAo conteúdo  irônico de Tweets",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      fontFamily: "WorkSansSemiBold"),
                ),

                ///Botão para abrir tela de Tweets
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Theme.Colors.azulLogoClaro,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Theme.Colors.azulLogoClaro,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: new LinearGradient(
                          colors: [
                            Theme.Colors.azulLogoClaro,
                            Theme.Colors.azulLogo
                          ],
                          begin: const FractionalOffset(0.2, 0.2),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.gray1,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "Listar Tweets",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontFamily: "WorkSansBold"),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => TweetsScreen()),
                              (Route<dynamic> route) => false);
                        }),
                  ),
                ),
              ],
            )));
  }
}

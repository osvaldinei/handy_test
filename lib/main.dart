import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:handy_test/src/screens/splash_screen.dart';
import 'package:handy_test/src/screens/tweets_screen.dart';
import 'package:handy_test/src/screens/wellcome_screen.dart';


void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141),
      ),
      debugShowCheckedModeBanner: false,
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
    ],  
    supportedLocales: [
      const Locale('pt')
    ],
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
       WellcomeScreen.tag: (context) => WellcomeScreen(),
       TweetsScreen.tag: (context) => TweetsScreen(),
    },
  ));
}



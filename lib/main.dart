import 'package:flutter/material.dart';
import 'package:handy_test/screens/splash_screen.dart';
import 'package:handy_test/screens/wellcome_page.dart';


void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141),
      ),
      debugShowCheckedModeBanner: false,
    home: new SplashScreen(),
    routes: <String, WidgetBuilder>{
       WellcomePage.tag: (context) => WellcomePage(),
    },
  ));
}



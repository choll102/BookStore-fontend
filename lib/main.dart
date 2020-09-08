import 'package:da_muasachonline/module/signup/signup_page.dart';
import 'package:da_muasachonline/shared/app_color.dart';
import 'package:flutter/material.dart';

import 'module/checkout/checkout_page.dart';
import 'module/home/home_page.dart';
import 'module/signin/signin_page.dart';
import 'module/splash/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        backgroundColor: Colors.blueAccent,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/home': (context) => HomePage(),
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage(),
        '/checkout': (context) => CheckoutPage(),
      },
    );
  }
}


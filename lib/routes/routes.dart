import 'package:flutter/material.dart';
import 'package:flutter_quiz_country/pages/quiz_page.dart';
import 'package:flutter_quiz_country/pages/result_page.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';

class Routing {
  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    final Object? data = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return PageTransition(
            type: PageTransitionType.bottomToTop,
            duration: Duration(milliseconds: 1000),
            child: const HomePage());
      case '/login':
        return PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 500),
            child: const LoginPage());

      case '/register':
        return PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 500),
            child: const RegisterPage());

      case '/quiz-page':
        return PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 1000),
            child: const QuizPage());
      case '/result-page':
        return PageTransition(
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 1000),
            child: ResultPage(score: data));
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(
                    child: Text("La route n'existe pas !!"),
                  ),
                ));
    }
  }
}

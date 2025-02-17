import 'package:flutter/material.dart';

import 'routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Country quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 81, 29, 204)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: Routing.generateRoutes,
    );
  }
}
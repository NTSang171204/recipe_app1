import 'package:flutter/material.dart';
import 'package:recipe_app/pages/home_page.dart';
import 'package:recipe_app/pages/onboarding_page.dart';
import 'package:recipe_app/pages/recipe_detail.dart';
import 'package:recipe_app/pages/saved_recipes.dart';
import 'package:recipe_app/pages/search_page.dart';
import 'package:recipe_app/pages/user_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/search':(context) => SearchPage(),
        '/bookmarks':(context) => SavedRecipeScreen(),
        '/profile':(context) => UserPage(),
      },
    );
  }
}

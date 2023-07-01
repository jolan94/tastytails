import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastytails/providers/recipe_provider.dart';
import 'package:tastytails/screens/recipe_categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tasty Tails',
        theme: ThemeData(
          colorSchemeSeed: Colors.purple,
          useMaterial3: true,
        ),
        home: const RecipeCategoriesScreen(),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tastytails/models/category.dart';
import 'package:tastytails/models/meal.dart';
import 'package:tastytails/models/recipe.dart';

class ApiService {
  static Future<List<Category>> fetchAllCategories() async {
    final url =
        Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final categories = jsonBody['categories'] as List;
      return categories.map((category) => Category.fromJson(category)).toList();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  static Future<List<Meal>> fetchMealsByCategory(String categoryId) async {
    final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final meals = jsonBody['meals'] as List;
      return meals.map((meal) => Meal.fromJson(meal)).toList();
    } else {
      throw Exception('Failed to fetch meals');
    }
  }

  static Future<Recipe> fetchRecipeDetails(String recipeId) async {
    final url = Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$recipeId');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final meals = jsonBody['meals'] as List;
      if (meals.isNotEmpty) {
        return Recipe.fromJson(meals[0]);
      } else {
        throw Exception('Recipe not found');
      }
    } else {
      throw Exception('Failed to fetch recipe details');
    }
  }

  static Future<Recipe> fetchRandomRecipe() async {
    final url = Uri.parse('https://www.themealdb.com/api/json/v1/1/random.php');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final meals = jsonBody['meals'] as List;
      if (meals.isNotEmpty) {
        return Recipe.fromJson(meals[0]);
      } else {
        throw Exception('Recipe not found');
      }
    } else {
      throw Exception('Failed to fetch recipe details');
    }
  }
}

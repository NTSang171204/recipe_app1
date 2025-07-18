import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/ingredient.dart';

class IngredientService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1/list.php?i=list';

  Future<List<Ingredient>> fetchIngredients() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List<dynamic> meals = jsonData['meals'] ?? [];
        return meals.map((json) => Ingredient.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load ingredients');
      }
    } catch (e) {
      throw Exception('Error fetching ingredients: $e');
    }
  }
}


class IngredientController extends ChangeNotifier {
  final IngredientService _service = IngredientService();
  List<Ingredient> _ingredients = [];
  bool _isLoading = false;
  String? _error;

  List<Ingredient> get ingredients => _ingredients;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchIngredients() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _ingredients = await _service.fetchIngredients();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}


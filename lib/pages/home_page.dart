import 'package:flutter/material.dart';
import 'package:recipe_app/Controllers/category_controller.dart';
import 'package:recipe_app/Controllers/meal_controller.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/recipe_card_model.dart';
import 'package:recipe_app/widgets/recent_recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/category_card.dart';
import '../widgets/ingredient_button.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; //trang hiện tại

  //recipe_card_by_country
  List<Meal> _meals = []; // arrays các meals fetch được từ đất nước
  bool _loadingMeals = true; //Đang load hay không
  bool _showAll = false; // Hiển thị tất cả hay không

  // Category buttons
  List<Categories> _categories = [];
  String _selectedCategory = '';
  bool _loadingCategories = true; // Đang load hay không

  //Category meals
  List<Meal> _categoryMeals = [];
  bool _loadingCategoryMeals = false;

  @override
  void initState() {
    super.initState();
    loadMeals();
    loadCategories();
  }

  //Function load các món ăn từ nước
  void loadMeals() async {
    try {
      final data = await MealController.fetchByArea('japanese');
      setState(() {
        _meals = data;
        _loadingMeals = false;
      });
    } catch (e) {
      setState(() => _loadingMeals = false);
    }
  }

  //Function load các category
  void loadCategories() async {
    try {
      final data = await CategoryController.fetchCategories();
      setState(() {
        _categories = data;
        _selectedCategory = data.first.name;
        _loadingCategories = false;
      });
    } catch (e) {
      setState(() => _loadingCategories = false);
    }
  }

  //functionload các category meals
  void loadMealsByCategory(String cat) async {
    setState(() {
      _loadingCategoryMeals = true;
    });
    try {
      final data = await CategoryMealController.fetchByCategory(cat);
      setState(() {
        _categoryMeals = data;
        _loadingCategoryMeals = false;
        _showAll = false;
      });
    } catch (e) {
      setState(() => _loadingCategoryMeals = false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.amber[700],
        shape: const CircleBorder(),
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                ),
              ),

              SizedBox(height: 16),
              // Vị trí
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nhật Bản',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút xem tất cả
                      setState(() {
                        _showAll = !_showAll; // Chuyển đổi trạng thái hiển thị
                      });
                    },
                    child: Text(
                      _showAll ? 'Ẩn bớt' : 'Xem tất cả',
                      style: TextStyle(color: Colors.amber[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Danh sách bài đăng
              SizedBox(
                height: 250,
                child:
                    _loadingMeals
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _showAll ? _meals.length : min(5, _meals.length),
                          itemBuilder: (context, i) {
                            final m = _meals[i];
                            return RecipeCard(
                              author: "Nguyễn Trương Sang",
                              imageUrl: m.thumbnail,
                              title: m.name,
                              duration: '',
                            );
                          },
                        ),
              ),

              // Danh mục món ăn
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Danh mục',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút xem tất cả
                      setState(() {
                        _showAll = !_showAll; // Chuyển đổi trạng thái hiển thị
                      });
                    },
                    child: Text(
                      _showAll ? 'Ẩn bớt' : 'Xem tất cả',
                      style: TextStyle(color: Colors.amber[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              _loadingCategories
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                    height: 40, // đủ cao để chứa các button có chiều cao ~25
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _showAll ? _categories.length : 5,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = _selectedCategory == cat.name;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IngredientButton(
                            label: cat.name,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedCategory = cat.name;
                                loadMealsByCategory(cat.name);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),

              SizedBox(height: 12),
              SizedBox(
                height: 210,
                child:
                    _loadingCategoryMeals
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _showAll
                                  ? _categoryMeals.length
                                  : min(5, _categoryMeals.length),
                          itemBuilder: (context, i) {
                            final m = _categoryMeals[i];
                            return CategoryCard(
                              imageUrl: m.thumbnail,
                              title: m.name,
                              author: "Nguyễn Trương Sang",
                              time: "1 tiếng 20 phút",
                            );
                          },
                        ),
              ),

              // Công thức gần đây
              SizedBox(height: 24),
              Text(
                'Công thức gần đây',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecentRecipe(
                      imageUrl:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                      title: "Mi xao",
                      authorName: "NTS",
                      authorAvatar:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                    ),
                    RecentRecipe(
                      imageUrl:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                      title: "Mi xao",
                      authorName: "NTS",
                      authorAvatar:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                    ),
                    RecentRecipe(
                      imageUrl:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                      title: "Mi xao",
                      authorName: "NTS",
                      authorAvatar:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                    ),
                    RecentRecipe(
                      imageUrl:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                      title: "Mi xao",
                      authorName: "NTS",
                      authorAvatar:
                          "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                    ),
                  ],
                ),
              ),

              // Nguyên liệu
              SizedBox(height: 24),
              Text(
                'Nguyên liệu',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                children: [
                  IngredientButton(label: 'Danh mục 1', isSelected: true),
                  IngredientButton(label: 'Danh mục 2'),
                  IngredientButton(label: 'Danh mục 3'),
                  IngredientButton(label: 'Danh mục 1'),
                  IngredientButton(label: 'Danh mục 2'),
                ],
              ),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

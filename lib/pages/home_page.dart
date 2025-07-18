import 'package:flutter/material.dart';
import 'package:recipe_app/Controllers/category_controller.dart';
import 'package:recipe_app/Controllers/ingredient_controller.dart';
import 'package:recipe_app/Controllers/meal_controller.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/recipe_card_model.dart';
import 'package:recipe_app/pages/recipe_detail.dart';
import 'package:recipe_app/widgets/recent_recipe.dart';
import 'package:recipe_app/widgets/search_bar.dart';
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
  int _currentIndex = 0; // Trang hiện tại

  //Searchbar
  final SearchMealController _searchController = SearchMealController();
  final TextEditingController _searchEditController = TextEditingController();

  //Meal theo khu vực
  List<Meal> _meals = []; // Danh sách meals theo khu vực
  bool _loadingMeals = true; // Đang load meals
  bool _showAll = false; // Hiển thị tất cả hay không

  //Theo category
  List<Categories> _categories = []; // Danh sách categories
  String _selectedCategory = ''; // Category được chọn
  bool _loadingCategories = true; // Đang load categories
  List<Meal> _categoryMeals = []; // Danh sách meals theo category
  bool _loadingCategoryMeals = false; // Đang load category meals

  //Danh sách ingredients
  final IngredientController _ingredientController = IngredientController();
  List<String> _selectedIngredientNames = []; // Danh sách nguyên liệu được chọn

  @override
  void initState() {
    super.initState();
    loadMeals();
    loadCategories();
    _ingredientController.fetchIngredients();
  }

  // Load meals theo khu vực
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

  // Load danh sách categories
  void loadCategories() async {
    try {
      final data = await CategoryController.fetchCategories();
      setState(() {
        _categories = data;
        _selectedCategory = data.isNotEmpty ? data.first.name : '';
        _loadingCategories = false;
      });
    } catch (e) {
      setState(() => _loadingCategories = false);
    }
  }

  // Load meals theo category
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

  @override
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
        child: CustomScrollView(
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: CustomSearchBar(
                controller: _searchEditController,
                onSearch: (query) async {
                  await _searchController.searchMeals(query);
                  setState( () {});
                },
                onSubmitted: (query) async {
                  await _searchController.searchMeals(query);
                  setState(() {});
                },
              ),
            ),
            SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final meal = _searchController.meals[index];
                return ListTile(
                  leading: Image.network(meal.thumbnail, width: 50, height: 50),
                  title: Text(meal.name),
                  trailing: Icon(Icons.more_horiz, color: Colors.grey[700]),
                  onTap: () {
                    //Điều hướng sang Recipe Detail Page khi ấn vào món ăn
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeDetailPage(title: meal.name,)));
                  },
                );
              },
              childCount: _searchController.meals.length,
            ),
          ),
            // Vị trí (Nhật Bản)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nhật Bản',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAll = !_showAll;
                        });
                      },
                      child: Text(
                        _showAll ? 'Ẩn bớt' : 'Xem tất cả',
                        style: TextStyle(color: Colors.amber[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Danh sách món ăn theo khu vực
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            // Danh mục món ăn
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh mục',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _showAll = !_showAll;
                        });
                      },
                      child: Text(
                        _showAll ? 'Ẩn bớt' : 'Xem tất cả',
                        style: TextStyle(color: Colors.amber[700]),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Danh sách categories
            SliverToBoxAdapter(
              child:
                  _loadingCategories
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                        height: 40,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _showAll ? _categories.length : 5,
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            final isSelected = _selectedCategory == cat.name;
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: 8,
                                left: 16,
                                bottom: 8
                              ),
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
            ),

            // Danh sách món ăn theo category
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            // Công thức gần đây
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Text(
                  'Công thức gần đây',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            // Nguyên liệu
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Text(
                  'Nguyên liệu',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: AnimatedBuilder(
                animation: _ingredientController,
                builder: (context, _) {
                  if (_ingredientController.isLoading) {
                    return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (_ingredientController.error != null) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(_ingredientController.error!)),
                    );
                  }
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 100 / 40,
                        ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final ingredient =
                          _ingredientController.ingredients[index];
                      return IngredientButton(
                        label: ingredient.name,
                        isSelected: _selectedIngredientNames.contains(
                          ingredient.name,
                        ),
                        onTap: () {
                          setState(() {
                            if (_selectedIngredientNames.contains(
                              ingredient.name,
                            )) {
                              _selectedIngredientNames.remove(ingredient.name);
                            } else {
                              _selectedIngredientNames.add(ingredient.name);
                            }
                          });
                        },
                      );
                    }, childCount: _ingredientController.ingredients.length),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

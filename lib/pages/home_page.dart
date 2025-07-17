import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/recent_recipe.dart';
import '../widgets/recipe_card.dart';
import '../widgets/category_card.dart';
import '../widgets/ingredient_button.dart';
import '../widgets/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: _currentIndex, onTap: (i) {
        setState(() {
          _currentIndex = i;
        });
      }),
      floatingActionButton: FloatingActionButton(onPressed: () {},
      backgroundColor: Colors.amber[700],
      shape: const CircleBorder(),
      child: Icon(Icons.add, color: Colors.white,),),
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
                    'TP. Hồ Chí Minh',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Xem tất cả',
                    style: TextStyle(color: Colors.amber[700]),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Danh sách bài đăng
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    RecipeCard(
                      imageUrl: 'https://via.placeholder.com/200',
                      title: 'Cách chiên trứng một cách cung phu',
                      author: 'Đinh Trọng Phúc',
                      duration: '1 tiếng 20 phút',
                    ),
                    RecipeCard(
                      imageUrl: 'https://via.placeholder.com/200',
                      title: 'Chiên trứng siêu ngon',
                      author: 'Đinh Trọng Phúc',
                      duration: '45 phút',
                    ),
                  ],
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
                  Text(
                    'Xem tất cả',
                    style: TextStyle(color: Colors.amber[700]),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Wrap(
                children: [
                  IngredientButton(label: 'Danh mục 1', isSelected: true),
                  IngredientButton(label: 'Danh mục 2'),
                  IngredientButton(label: 'Danh mục 3'),
                  IngredientButton(label: 'Danh mục 1'),
                  IngredientButton(label: 'Danh mục 2'),
                ],
              ),
              SizedBox(
                height: 210,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryCard(
                      imageUrl:
                          'https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg',
                      title: 'Trứng chiên',
                      author: 'Trần Đình Trọng',
                      time: '20 phút',
                    ),
                    CategoryCard(
                      imageUrl:
                          'https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg',
                      title: 'Mì xào',
                      author: 'Trần Đình Trọng',
                      time: '25 phút',
                    ),
                    CategoryCard(
                      imageUrl:
                          'https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg',
                      title: 'Mì xào',
                      author: 'Trần Đình Trọng',
                      time: '25 phút',
                    ),
                  ],
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

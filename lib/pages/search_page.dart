import 'package:flutter/material.dart';
import 'package:recipe_app/pages/recipe_detail.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_app/widgets/bottom_nav_bar.dart';
import 'package:recipe_app/widgets/ingredient_button.dart';
import 'package:recipe_app/widgets/search_card.dart';
import 'dart:convert';

class SearchPage extends StatefulWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1; // Đặt chỉ mục mặc định cho trang tìm kiếm
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredItems = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.query; // Đặt query vào TextField
    _searchController.addListener(_filterItems);
    fetchMeals(widget.query); // Gọi API với query ban đầu
  }

  Future<void> fetchMeals(String query) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$query'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _filteredItems = (data['meals'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Lỗi khi tải dữ liệu';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Lỗi: $e';
        isLoading = false;
      });
    }
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    fetchMeals(query); // Gọi lại API khi người dùng nhập lại
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7,
              minChildSize: 0.3,
              maxChildSize: 0.95,
              expand: false,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Lọc', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    // Đặt lại trạng thái lọc (nếu cần)
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text('Đặt lại', style: TextStyle(color: Colors.amber)),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Danh mục', style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          IngredientButton(label: 'Danh mục 1', isSelected: true),
                          IngredientButton(label: 'Danh mục 2', isSelected: false),
                          IngredientButton(label: 'Danh mục 3', isSelected: false),
                          IngredientButton(label: 'Danh mục 4', isSelected: false),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Nguyên liệu', style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          IngredientButton(label: 'Thịt gà', isSelected: true),
                          IngredientButton(label: 'Thịt heo', isSelected: false),
                          IngredientButton(label: 'Ức gà', isSelected: false),
                          IngredientButton(label: 'Chân gà', isSelected: false),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text('Khu vực', style: TextStyle(fontWeight: FontWeight.bold)),
                      Wrap(
                        spacing: 8.0,
                        children: [
                          IngredientButton(label: 'TP.HCM', isSelected: true),
                          IngredientButton(label: 'Bình Phước', isSelected: false),
                          IngredientButton(label: 'Đồng Nai', isSelected: false),
                          IngredientButton(label: 'An Giang', isSelected: false),
                          IngredientButton(label: 'Long An', isSelected: false),
                        ],
                      ),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Thêm logic lọc nếu cần
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Xác nhận', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý khi nhấn nút thêm
        },
        backgroundColor: Colors.amber[700],
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Tìm kiếm món ăn',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                        ),
                        onSubmitted: (query) {
                          fetchMeals(query); // Tìm kiếm lại khi nhấn Enter
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.outlined(
                      onPressed: _showFilterBottomSheet,
                      icon: Icon(Icons.filter_alt_sharp, color: Colors.amber[700]),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : _filteredItems.isEmpty
                          ? Center(child: Text('Không tìm thấy món ăn'))
                          : null,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = _filteredItems[index];
                    return RecipeCardSearch(
                      imageUrl: item['strMealThumb'] ?? 'https://via.placeholder.com/600x400',
                      title: item['strMeal'] ?? 'Unknown',
                      author: item['strSource'] ?? 'Ẩn danh',
                      time: '30m', // API không cung cấp thời gian, sử dụng giá trị mặc định
                      onTap: () {
                        // Điều hướng sang RecipeDetailPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(title: item['strMeal'] ?? ''),
                          ),
                        );
                      },
                    );
                  },
                  childCount: _filteredItems.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
// Đảm bảo các import này đúng với đường dẫn file của bạn
import 'package:recipe_app/widgets/bottom_nav_bar.dart';
import 'package:recipe_app/widgets/ingredient_button.dart';
import 'package:recipe_app/widgets/search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1; // Đặt chỉ mục mặc định cho trang tìm kiếm
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _items = [
    {
      'imageUrl': 'https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg',
      'title': 'How to not get cooked',
      'author': 'NTS',
      'time': '30m',
    },
    {
      'imageUrl': 'https://via.placeholder.com/600x400/0000FF/FFFFFF?text=help+me',
      'title': 'help me',
      'author': 'NTS',
      'time': '15m',
    },
    {
      'imageUrl': 'https://via.placeholder.com/600x400/00FF00/FFFFFF?text=got+cooked+anyway',
      'title': 'got cooked anyway',
      'author': 'NTS',
      'time': '45m',
    },
  ];

  List<Map<String, String>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _items.where((item) {
        final title = item['title']!.toLowerCase();
        final author = item['author']!.toLowerCase();
        return title.contains(query) || author.contains(query);
      }).toList();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Cho phép bottom sheet chiếm toàn bộ chiều cao cần thiết
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.7, // Chiều cao ban đầu (70% màn hình)
              minChildSize: 0.3, // Chiều cao tối thiểu
              maxChildSize: 0.95, // Chiều cao tối đa
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
                                    // Đặt lại trạng thái (ví dụ: xóa lựa chọn)
                                  });
                                  Navigator.pop(context); // Đóng bottom sheet
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
                          Navigator.pop(context); // Đóng bottom sheet
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Thanh tìm kiếm và nút lọc
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.outlined(
                    onPressed: _showFilterBottomSheet,
                    icon: Icon(Icons.filter_alt_sharp, color: Colors.amber[700]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Danh sách kết quả
              GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.75, // Tỷ lệ khung hình của mỗi ô
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredItems.length,
                itemBuilder: (context, index) {
                  final item = _filteredItems[index];
                  return RecipeCardSearch(
                    imageUrl: item['imageUrl']!,
                    title: item['title']!,
                    author: item['author']!,
                    time: item['time']!,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
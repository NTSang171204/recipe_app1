import 'package:flutter/material.dart';
// Đảm bảo các import này đúng với đường dẫn file của bạn
 import 'package:recipe_app/widgets/bottom_nav_bar.dart';
 import 'package:recipe_app/widgets/search_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  int _currentIndex = 1; // Đặt chỉ mục mặc định cho trang tìm kiếm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Thanh điều hướng dưới cùng
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Khi nhấn vào một item, cập nhật trạng thái và điều hướng
          setState(() {
            _currentIndex = index;
          });
          // Logic điều hướng đã được xử lý trong BottomNavBar,
          // nên không cần pushNamed ở đây nữa để tránh đẩy nhiều route lên stack
          // nếu BottomNavBar đã xử lý việc đó.
          // Tuy nhiên, nếu bạn muốn SearchPage là một phần của PageView hoặc IndexedStack
          // thì logic này cần được thay đổi để điều khiển PageController.
        },
      ),
      // Nút hành động nổi
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Xử lý khi nhấn nút thêm
        },
        backgroundColor: Colors.amber[700],
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // Nội dung chính của trang
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
                  // TextField được bọc trong Expanded để chiếm hết không gian còn lại
                  // trong Row, tránh lỗi overflow.
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm sản phẩm',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16), // Thêm padding ngang
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Khoảng cách giữa TextField và IconButton
                  IconButton.outlined(
                    onPressed: () {
                      // Xử lý khi nhấn nút lọc
                    },
                    icon: Icon(Icons.filter_alt_sharp, color: Colors.amber[700]),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RecipeCardSearch(
                imageUrl: "https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg",
                title: "How to not get cooked",
                author: "NTS",
                time: "30m", // Đặt giá trị thời gian hợp lý
              ),
              RecipeCardSearch(
                imageUrl: "https://via.placeholder.com/600x400/0000FF/FFFFFF?text=help+me",
                title: "help me",
                author: "NTS",
                time: "15m",
              ),
              RecipeCardSearch(
                imageUrl: "https://via.placeholder.com/600x400/00FF00/FFFFFF?text=got+cooked+anyway",
                title: "got cooked anyway",
                author: "NTS",
                time: "45m",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/bottom_nav_bar.dart';
import 'package:recipe_app/widgets/ingredient_button.dart';

class UserPage extends StatelessWidget {
  final Map<String, dynamic> userData = {
    'avatarUrl': 'https://i.imgur.com/BoN9kdC.png', // URL giả
    'name': 'Nguyễn Đình Trọng',
    'color': Color(0xFFA47804),
    'stats': [
      {'label': 'Bài viết', 'value': 100},
      {'label': 'Người theo dõi', 'value': 100},
      {'label': 'Theo dõi', 'value': 100},
    ],
  };

  final List<String> favoriteImages = List.generate(
    9,
    (index) => 'https://www.themealdb.com/images/media/meals/xqvyqr1511638875.jpg', // ảnh salad giả
  );

  int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang cá nhân'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Avatar + Tên + Follow/Message
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(userData['avatarUrl']),
                ),
                SizedBox(height: 8),
                Text(
                  userData['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: userData['color'],
                  ),
                ),
                SizedBox(height: 12),
                // Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: userData['stats'].map<Widget>((stat) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            '${stat['value']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            stat['label'],
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12),
                // Follow & Message buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FollowButton(label: "Follow"),
                    
                    SizedBox(width: 12),
                    MessageButton(label: "Message"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),

            // Danh sách yêu thích
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Danh sách yêu thích',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 10),

            // Grid ảnh
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: favoriteImages.map((url) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    url,
                    width: (MediaQuery.of(context).size.width - 40) / 3,
                    height: (MediaQuery.of(context).size.width - 40) / 3,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 80), // để tránh bị che bởi bottom bar
          ],
        ),
      ),

      // Floating Action Button
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          (() {
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
    );
  }
}

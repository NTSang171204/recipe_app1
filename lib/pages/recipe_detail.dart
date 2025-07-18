import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetailPage extends StatefulWidget {
  final String title;

  const RecipeDetailPage({super.key, required this.title});

  @override
  _RecipeDetailPageState createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  Map<String, dynamic>? mealData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchMealData();
  }

  Future<void> fetchMealData() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=${widget.title}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['meals'] != null && data['meals'].isNotEmpty) {
          setState(() {
            mealData = data['meals'][0];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Không tìm thấy món ăn';
            isLoading = false;
          });
        }
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

  List<Map<String, String>> getIngredientsAndMeasures() {
    List<Map<String, String>> ingredients = [];
    if (mealData == null) return ingredients;

    for (int i = 1; i <= 20; i++) {
      String? ingredient = mealData!['strIngredient$i'];
      String? measure = mealData!['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty && measure != null && measure.isNotEmpty) {
        ingredients.add({'ingredient': ingredient, 'measure': measure});
      }
    }
    return ingredients;
  }

  Future<void> _launchYouTube(String url) async {
    if (url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể mở link YouTube')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Chi tiết"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // Xử lý khi nhấn nút yêu thích
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Banner
                      Image.network(
                        mealData?['strMealThumb'] ?? 'https://via.placeholder.com/600x300',
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                      ),
                      // Danh sách hình ảnh nhỏ (Placeholder)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.network(
                                  mealData?['strMealThumb'] ?? 'https://via.placeholder.com/600x300',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  mealData?['strMeal'] ?? widget.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite_border,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                              ],
                            ),
                            Text(
                              mealData?['strMeal'] ?? widget.title,
                              style: const TextStyle(fontSize: 13, color: Colors.grey),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  "4.2 | 120 đánh giá", // Giá trị tĩnh, có thể cập nhật từ API nếu có
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundImage: NetworkImage(
                                    "https://via.placeholder.com/32/000000/FFFFFF?text=Avatar",
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text("Nguyễn Trương Sang", style: TextStyle(color: Color(0xffCEA700), fontSize: 18, fontWeight: FontWeight.w600),),
                              ],
                            ),
                            Divider(
                              color: Color(0xffCEA700),
                              thickness: 1.5,
                              height: 20.0,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Danh cho 2-4 người ăn",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            // Danh sách nguyên liệu
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: getIngredientsAndMeasures().map((item) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Text(
                                    '${item['ingredient']} | ${item['measure']}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 16),
                            // Nút Xem video
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  _launchYouTube(mealData?['strYoutube'] ?? '');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xfffcff87),
                                  minimumSize: const Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.play_arrow_outlined, color: Color(0xffCEA700)),
                                    Text(
                                  "Xem video",
                                  style: TextStyle(color: Color(0xffCEA700)),
                                ),
                                  ],)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
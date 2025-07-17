import 'package:flutter/material.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title = "Cách chén trùng mót cạch cúng phu";
  final String author = "Đinh Trọng Phúc";
  final double rating = 4.2;
  final int reviewCount = 120;
  final String bannerImageUrl =
      "https://via.placeholder.com/600x300/FF0000/FFFFFF?text=Banner+Recipe";
  final List<String> ingredientCategories = [
    "Dành cho 2-4 người ăn",
    "300g chà là, lộc trong 20 phút",
    "2 chiếc xích bố",
    "5 ván bố",
    "100g bần sàn, lộc cho đen miếm",
    "1 quỹ trưng đàn tan",
    "50 cái xan, đát thán 4 miền",
    "Dở tôi bờ gà",
    "15g tì",
    "3g mắm tôm",
    "25g hần tím",
    "50g đường thom",
    "100g đt bỏm",
    "50g t cay",
    "7g mùi",
    "15g đường",
    "15g hần tày chiền",
    "25g bố tà",
    "50ml đà ăn",
  ];

  RecipeDetailPage({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Image.network(
              bannerImageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => const Icon(Icons.error),
            ),
            // Danh sách hình ảnh nhỏ
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder cho 5 hình ảnh
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
                        "https://via.placeholder.com/80/FF0000/FFFFFF?text=Image+$index",
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) =>
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
                        title,
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
                    title,
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        "$rating | $reviewCount đánh giá",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 16),
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
                      Text(author),
                    ],
                  ),
                  Divider(
                    color: Color(0xffCEA700), // Đổi màu ở đây
                    thickness: 1.5, // Độ dày của đường kẻ
                    height:
                        20.0, // Chiều cao tổng thể (bao gồm khoảng cách trên/dưới)
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
                    children:
                        ingredientCategories
                            .map(
                              (ingredient) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 2.0,
                                ),
                                child: Text(ingredient),
                              ),
                            )
                            .toList(),
                  ),
                  const SizedBox(height: 16),
                  // Nút Xem video
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Xử lý khi nhấn "Xem video"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Xem video",
                        style: TextStyle(color: Colors.white),
                      ),
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

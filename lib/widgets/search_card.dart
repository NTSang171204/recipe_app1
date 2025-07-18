import 'package:flutter/material.dart';

class RecipeCardSearch extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String time;
  final VoidCallback ? onTap;

    const RecipeCardSearch({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Gọi callback khi nhấn
      child: Container(
        width: 210,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0x26CEA700),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF734C10),
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Tạo bởi",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF432805),
              ),
            ),
            Text(
              author,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF432805),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Color(0xFF432805)),
                ),
                Icon(
                  Icons.article_outlined,
                  size: 20,
                  color: Color(0xFF432805),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
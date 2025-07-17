import 'package:flutter/material.dart';

class RecentRecipe extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String authorName;
  final String authorAvatar;

  const RecentRecipe({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.authorName,
    required this.authorAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 133,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Anh cua mon an
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 133,
              width: 133,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),

          //Tieu de mon an
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF734C10), // Mau xanh dam)
            ),
          ),
          SizedBox(height: 6),

          //Avatar + ten nguoi tao
          Row(
            children: [
              CircleAvatar(radius: 12, backgroundColor: Colors.grey),
              const SizedBox(width: 6),
              Text(
                authorName,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF002D73),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

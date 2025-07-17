import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String time;

  const CategoryCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.time,
  });

  @override
Widget build(BuildContext context) {
  return Stack(
    clipBehavior: Clip.none, // Cho phép ảnh nổi ra ngoài
    children: [
      Container(
        width: 210,
        margin: EdgeInsets.only(right: 12, top: 40),
        padding: EdgeInsets.only(top: 50, left: 12, right: 12, bottom: 12),
        decoration: BoxDecoration(
          color: Color(0x26CEA700),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF734C10), fontSize: 20)),
            Text("Tạo bởi", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF432805),)),
            Text("$author", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Color(0xFF4322805)),),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(time, style: TextStyle(fontSize: 12, color: Color(0xFF432805))),
                Icon(Icons.article_outlined, size: 20, color: Color(0xFF432805)),
              ],
            ),
          ],
        ),
      ),

      Positioned(
        top: 0,
        left: 210 / 2 - 40, 
        child: ClipOval(
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}}
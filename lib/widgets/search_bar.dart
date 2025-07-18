import 'package:flutter/material.dart';
import 'package:recipe_app/pages/search_page.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final Function(String) onSubmitted;
  final String hintText;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    required this.onSearch,
    required this.onSubmitted,
    this.hintText = 'Tìm kiếm sản phẩm',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: onSearch,
        onSubmitted: (query) {
        onSubmitted(query);
        // Điều hướng sang SearchPage khi nhấn Enter
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(query: query),
          ),
        );
      },
      ),
    );
  }
}
import 'package:flutter/material.dart';

class IngredientButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const IngredientButton({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      padding: EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFCEA700) : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 10),
      ),
    );
  }
}

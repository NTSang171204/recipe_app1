import 'package:recipe_app/widgets/ingredient_button.dart';
import 'package:flutter/material.dart';
class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close icon & "Đặt lại"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.close),
              Text(
                'Lọc',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  backgroundColor: Color(0xFFF4EEC9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  'Đặt lại',
                  style: TextStyle(
                    color: Color(0xFFCEA700),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),
          Divider(),

          _buildSection(
            title: 'Danh mục',
            items: [
              IngredientButton(label: 'Danh mục 1', isSelected: true),
              IngredientButton(label: 'Danh mục 2'),
              IngredientButton(label: 'Danh mục'),
              IngredientButton(label: 'Danh mục 3'),
              IngredientButton(label: 'Danh mục 4'),
            ],
          ),

          _buildSection(
            title: 'Nguyên liệu',
            items: [
              IngredientButton(label: 'Thịt gà', isSelected: true),
              IngredientButton(label: 'Thịt heo'),
              IngredientButton(label: 'Danh mục'),
              IngredientButton(label: 'Ức gà'),
              IngredientButton(label: 'Chân gà'),
            ],
          ),

          _buildSection(
            title: 'Khu vực',
            items: [
              IngredientButton(label: 'TP.HCM'),
              IngredientButton(label: 'Bình Phước'),
              IngredientButton(label: 'Đồng Nai'),
              IngredientButton(label: 'An Giang'),
              IngredientButton(label: 'Long An', isSelected: true),
            ],
          ),

          SizedBox(height: 24),

          // Xác nhận button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFCEA700),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Xác nhận',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📁 $title',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Wrap(
            children: items,
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/ingredient_button.dart';
import 'package:recipe_app/widgets/recipe_card.dart';



class SavedRecipeScreen extends StatefulWidget {
  const SavedRecipeScreen({super.key});

  @override
  State<SavedRecipeScreen> createState() => _SavedRecipeScreenState();
}

class _SavedRecipeScreenState extends State<SavedRecipeScreen> {
  bool isVideoSelected = true;

  // 🔹 Danh sách công thức mẫu (giống nhau)
  final int recipeCount = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Công thức', style: TextStyle(color: Color(0xffA47804),  )),
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔘 Tabs: Video | Công thức
            Row(
              children: [
                TabButton(
                  label: 'Video',
                  isSelected: isVideoSelected,
                  onTap: () {
                    setState(() {
                      isVideoSelected = true;
                    });
                  },
                ),
                const SizedBox(width: 8),
                TabButton(
                  label: 'Công thức',
                  isSelected: !isVideoSelected,
                  onTap: () {
                    setState(() {
                      isVideoSelected = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 📃 Danh sách công thức (dùng ListView.builder)
            Expanded(
              child: ListView.builder(
                itemCount: recipeCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SavedRecipeCard(
                      videoThumbnail:
                          'https://www.themealdb.com/images/media/meals/qqwypw1504642429.jpg',
                      duration: '1 tiếng 20 phút',
                      title: 'Cách chiên trứng một cách cung phu',
                      authorName: 'Đinh Trọng Phúc',
                      authorAvatar: 'https://example.com/avatar.jpg',
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


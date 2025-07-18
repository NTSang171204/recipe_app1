import 'package:flutter/material.dart';
import 'package:recipe_app/pages/recipe_detail.dart';

class RecipeCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final String duration;

  const RecipeCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailPage(title: title),
          ),
        );
      },
      child: Container(
        width: 206,
        margin: EdgeInsets.only(right: 12),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  duration,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                  iconSize: 20,
                ),
              ],
            ),
            Text(title),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      author,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange[800],
                      ),
                      overflow: TextOverflow.ellipsis,
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
//Recipe Card in saved recipes

class SavedRecipeCard extends StatelessWidget {
  final String videoThumbnail;
  final String duration;
  final String title;
  final String authorName;
  final String authorAvatar;

  const SavedRecipeCard({
    required this.videoThumbnail,
    required this.duration,
    required this.title,
    required this.authorName,
    required this.authorAvatar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Video thumbnail
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                videoThumbnail,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const Positioned.fill(
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 48,
                  color: Colors.white,
                ),
              ),
            ),
            const Positioned(
              top: 8,
              left: 8,
              child: Icon(Icons.star, color: Colors.yellow, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Duration and heart icon
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(duration, style: const TextStyle(color: Colors.blue)),
            const Icon(Icons.favorite_border),
          ],
        ),
        const SizedBox(height: 4),

        // Title
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),

        // Author info
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(authorAvatar),
            ),
            const SizedBox(width: 8),
            Text(authorName, style: const TextStyle(color: Colors.amber)),
          ],
        ),
      ],
    );
  }
}

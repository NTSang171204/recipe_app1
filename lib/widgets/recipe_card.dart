import 'package:flutter/material.dart';

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
    return Container(
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
              Text(duration, style: TextStyle(color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w500)),
              IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border), iconSize: 20,)
            ],
          ),
          Text(title,),
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  String getLastThreeWords(String text) {
    final words = text.split(' ');
    return words.length > 3 ? words.sublist(words.length - 3).join(' ') : text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          getLastThreeWords(title),
          style: const TextStyle(
              color: AppColors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 10),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

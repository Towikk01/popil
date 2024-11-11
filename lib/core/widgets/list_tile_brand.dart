import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';

class ListTileBrand extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback? onTap;

  const ListTileBrand({
    super.key,
    required this.imageUrl,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 24, // Adjust size as needed
        ),
        title: Text(
          title,
          style: theme.textTheme.titleSmall,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.orange,
        ),
        tileColor: Colors.grey[900], // Background color of the tile
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.orange),
        ),

        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}

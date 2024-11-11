import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';
import 'package:popil/core/widgets/product_category.dart';
import 'package:dio/dio.dart';
import 'package:popil/screens/brand_list_screen.dart';
import 'package:popil/screens/item_list_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.dio});

  final Dio dio;

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Табак',
      'image': 'assets/tobacco.jpg',
      "link": 'https://popil.com.ua/tyutyun',
      "icon": 'assets/icons/HookahSVG.svg'
    },
    {
      'title': 'Уголь',
      'image': 'assets/coal.jpg',
      "link": 'https://popil.com.ua/vugillja',
      "icon": 'assets/icons/CoalCubesSVG.svg'
    },
    {
      'title': 'Расходники',
      'image': 'assets/mousepices.webp',
      "link": 'https://popil.com.ua/v-tratni-matjerial',
      "icon": 'assets/icons/DisposableMouthpieceSVG.svg'
    },
    {
      'title': 'Аксессуары',
      'image': 'assets/accessories.jpg',
      'link': 'https://popil.com.ua/aksjesuar',
      'icon': "assets/icons/HookahBowlSVG.svg"
    },
  ];

  void _navigateToCategory(
      BuildContext context, String categoryTitle, String link) {
    if (categoryTitle == 'Табак') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BrandListScreen(dio: dio),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ItemListScreen(
            category: categoryTitle,
            link: link,
            dio: dio, // Pass dio here
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: AppColors.orange),
        title: const Text(
          'Ассортимент',
          style: TextStyle(
            fontSize: 28,
            color: AppColors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: categories.map((category) {
            return ProductCategory(
              onTap: () => _navigateToCategory(
                context,
                category['title'],
                category['link'],
              ),
              image: category['image'],
              title: category['title'],
              icon: category['icon'],
            );
          }).toList(),
        ),
      ),
    );
  }
}

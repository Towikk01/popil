import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: AppColors.orange,
        unselectedItemColor: AppColors.white,
        backgroundColor: Colors.transparent,
        currentIndex: currentIndex,
        onTap: onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Домой',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps_outlined),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Корзина',
          ),
        ]);
  }
}

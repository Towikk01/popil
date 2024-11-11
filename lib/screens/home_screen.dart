import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popil/core/widgets/bottom_nav_bar.dart';
import 'package:popil/screens/cart_screen.dart';
import 'package:popil/screens/catalog_screen.dart';
import 'package:popil/screens/hello_screen.dart';

class HomeScreen extends StatefulWidget {
  final Dio dio;
  const HomeScreen({super.key, required this.dio});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HelloScreen(
          onSelectCatalog: () => _onItemTapped(1)), // Set index to Catalog tab
      CatalogScreen(dio: widget.dio), // Pass dio to CatalogScreen
      const CartScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _screens[_index],
      bottomNavigationBar: BottomNavBar(
        onItemTapped: _onItemTapped,
        currentIndex: _index,
      ),
    );
  }
}

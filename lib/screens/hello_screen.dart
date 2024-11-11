
import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';
import 'package:popil/core/widgets/background_image.dart';

class HelloScreen extends StatelessWidget {
  final VoidCallback? onSelectCatalog;

  const HelloScreen({super.key, this.onSelectCatalog});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Popil.in.ua for Евр азіци',
          style: TextStyle(
            fontSize: 28,
            color: AppColors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: BackgroundImage(
            sigmaX: 5,
            sigmaY: 5,
            opacity: 0.1,
            image: 'assets/welcome.jpg',
            child: Positioned(
              top: size.height * 0.15,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Добро пожаловать в Popil.in.ua',
                      style: TextStyle(
                        color: Colors.orange[300],
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Подберите что-то дымное для себя',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: onSelectCatalog ??
                            () {}, // Provide default empty callback
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Colors.orange[300],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Подобрать',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_right_alt_sharp,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

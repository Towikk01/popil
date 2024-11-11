import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';
import "package:flutter_svg/flutter_svg.dart";

class ProductCategory extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;
  final String icon;

  const ProductCategory(
      {super.key,
      required this.image,
      required this.title,
      required this.onTap,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.orange, width: 1),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            opacity: 0.55,
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.orange,
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: SvgPicture.asset(icon,
                          height: 50, width: 50, color: AppColors.orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';

final theme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primarySwatch: Colors.orange,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.orange),
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
          fontSize: 28, color: AppColors.orange, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(
          fontSize: 20, color: AppColors.orange, fontWeight: FontWeight.w600),
    ));

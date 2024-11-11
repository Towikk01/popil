import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popil/core/bloc/brands_bloc/brands_bloc.dart';
import 'package:popil/core/bloc/items_bloc/items_bloc.dart';
import 'package:popil/core/utils/product_service.dart';
import 'package:popil/screens/catalog_screen.dart';
import 'package:popil/screens/home_screen.dart';
import 'package:popil/theme/theme.dart';
import 'package:popil/core/bloc/cart_bloc/cart_bloc.dart';

void main() {
  final dio = Dio();
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;
  const MyApp({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        BlocProvider<BrandsBloc>(
          create: (context) => BrandsBloc(dio: dio),
        ),
        BlocProvider<ItemsBloc>(
          create: (context) => ItemsBloc(productService: ProductService(dio)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Popil',
        theme: theme,
        home: HomeScreen(dio: dio),
        routes: {
          '/home': (context) => HomeScreen(dio: dio),
          '/catalog': (context) => CatalogScreen(dio: dio),
        },
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:popil/core/bloc/brands_bloc/brands_bloc.dart';
import 'package:popil/core/theme/app_colors.dart';
import 'package:popil/core/widgets/list_tile_brand.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popil/screens/item_list_screen.dart';

class BrandListScreen extends StatefulWidget {
  final Dio dio;
  const BrandListScreen({super.key, required this.dio});

  @override
  State<BrandListScreen> createState() => _BrandListScreenState();
}

class _BrandListScreenState extends State<BrandListScreen> {
  late final BrandsBloc _brandsBloc;
  @override
  void initState() {
    super.initState();
    _brandsBloc = BrandsBloc(dio: widget.dio)..add(LoadBrands());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppColors.orange),
          backgroundColor: Colors.black,
          title: const Text('Табак - Бренды',
              style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _brandsBloc.add(LoadBrands(isRefresh: true)); // Trigger refresh
          },
          child: BlocBuilder<BrandsBloc, BrandsState>(
            bloc: _brandsBloc,
            builder: (context, state) {
              if (state is BrandsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is BrandsFailure) {
                return Center(
                  child: Text('Failed to load brands: ${state.errorMessage}',
                      style: const TextStyle(color: Colors.red)),
                );
              }
              if (state is BrandsSuccess) {
                return ListView.builder(
                    itemCount: state.brands.length,
                    itemBuilder: (context, index) {
                      final brand = state.brands[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemListScreen(
                                dio: widget.dio,
                                category: brand['title'],
                                link: brand['link'],
                              ),
                            ),
                          );
                        },
                        child: ListTileBrand(
                            title: brand['title'],
                            imageUrl: brand['image'],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemListScreen(
                                    dio: widget.dio,
                                    category: brand['title'],
                                    link: brand['link'],
                                  ),
                                ),
                              );
                            }),
                      );
                    });
              }
              return const SizedBox.shrink();
            },
          ),
        ));
  }
}

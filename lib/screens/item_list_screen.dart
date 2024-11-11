import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popil/core/bloc/items_bloc/items_bloc.dart';
import 'package:popil/core/theme/app_colors.dart';
import 'package:popil/core/utils/product_service.dart';
import 'package:popil/core/widgets/category_button.dart';
import 'package:popil/core/widgets/product_card.dart';

class ItemListScreen extends StatelessWidget {
  final String category;
  final String link;
  final Dio dio;

  const ItemListScreen({
    super.key,
    required this.category,
    required this.link,
    required this.dio,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc(productService: ProductService(dio))
        ..add(LoadItems(link, 0)), // Load the items when screen is built
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            category,
            style: const TextStyle(
              color: AppColors.orange,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: const IconThemeData(color: AppColors.orange),
        ),
        body: Column(
          children: [
            // Row of Category Buttons
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<ItemsBloc, ItemsState>(
                builder: (context, state) {
                  if (state is ItemsSuccess &&
                      state.categories != null &&
                      state.items.isNotEmpty) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.categories!.map((category) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    8.0), // Adjust horizontal spacing here
                            child: CategoryButton(
                              title: category['title'],
                              imageUrl: category['image'],
                              onTap: () {
                                context
                                    .read<ItemsBloc>()
                                    .add(LoadItems(category['link'], 0));
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ItemsBloc, ItemsState>(
                builder: (context, state) {
                  if (state is ItemsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ItemsFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (state is ItemsSuccess) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 10),
                        child: Column(
                          children: [
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.55,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemCount: state.items.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = state.items[index];
                                return ProductCard(
                                  title: item['title'],
                                  imageUrl: item['image'],
                                  price: item['price'],
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                            if (!state.isLastPage && state.items.isNotEmpty)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(
                                      color: AppColors.orange, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<ItemsBloc>().add(LoadNextPage(
                                      link, state.currentPage + 1));
                                },
                                child: const Text('Еще!',
                                    style: TextStyle(
                                        fontSize: 18, color: AppColors.orange)),
                              ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

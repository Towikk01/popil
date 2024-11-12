import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popil/core/bloc/cart_bloc/cart_bloc.dart';
import 'package:popil/core/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String price;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final String uniqueId = title;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        int quantity = 0;
        if (state is CartSuccess) {
          final item = state.items.firstWhere(
            (item) => item.id == uniqueId,
            orElse: () => CartItem(
              id: uniqueId,
              imageUrl: imageUrl,
              title: title,
              price: price,
              quantity: 0,
            ),
          );
          quantity = item.quantity;
        }

        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.orange, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                price.trim(),
                style: const TextStyle(color: AppColors.orange),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      final cartItem = CartItem(
                        id: uniqueId,
                        imageUrl: imageUrl,
                        title: title,
                        price: price,
                      );
                      context
                          .read<CartBloc>()
                          .add(RemoveItemFromCart(cartItem));
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(Icons.remove, color: Colors.white)),
                  ),
                  Text('$quantity',
                      style: const TextStyle(color: Colors.white)),
                  GestureDetector(
                    onTap: () {
                      final cartItem = CartItem(
                        id: uniqueId,
                        imageUrl: imageUrl,
                        title: title,
                        price: price,
                      );
                      context.read<CartBloc>().add(AddItemToCart(cartItem));
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Icon(Icons.add, color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';
import 'package:popil/core/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popil/core/widgets/cart_item_list_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Корзина',
          style: TextStyle(
            fontSize: 28,
            color: AppColors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ошибка: ${state.errorMessage}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartSuccess) {
              if (state.items.isEmpty) {
                return const Center(
                  child: Text(
                    'Ваша корзина пустая',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.items.length,
                        itemBuilder: (context, index) {
                          final item = state.items[index];
                          return CartItemListTile(item: item);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      // 'Общая сумма: ₽${state.items.fold(0.0, (sum, item) => sum + double.parse(item.price) * item.quantity).toStringAsFixed(2)}',
                      'kek',
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

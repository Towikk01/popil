import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                      // Calculate the total price using the cleaned prices
                      'Общая сумма: ${_calculateTotalPrice(state.items)} грн.',
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        _showCheckoutDialog(context, state.items);
                      },
                      child: const Text('Оформить заказ'),
                    ),
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

  // Method to clean the price and convert it to a double
  double _parsePrice(String priceString) {
    // Remove all non-numeric characters, keep only digits and decimal point
    final cleanedString = priceString.replaceAll(RegExp(r'[^\d.]'), '');

    // Convert the cleaned string to double, returning 0 if it's invalid
    return double.tryParse(cleanedString) ?? 0.0;
  }

  // Calculate the total price of the cart
  double _calculateTotalPrice(List<CartItem> items) {
    double total = 0.0;
    for (var item in items) {
      total += _parsePrice(item.price) * item.quantity;
    }
    return total;
  }

  void _showCheckoutDialog(BuildContext context, List<CartItem> items) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final postOfficeController = TextEditingController();
    final placeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Оформление заказа'),
          content: SingleChildScrollView(
            // Add scroll view here
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: placeController,
                  decoration: const InputDecoration(labelText: 'Ресторан'),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Имя'),
                ),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Телефон'),
                ),
                TextField(
                  controller: postOfficeController,
                  decoration:
                      const InputDecoration(labelText: 'Отделение новой почты'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final message = _generateCheckoutMessage(
                  placeController.text,
                  nameController.text,
                  phoneController.text,
                  postOfficeController.text,
                  items,
                );
                _copyToClipboard(context, message); // Pass context here
                Navigator.of(context).pop();
              },
              child: const Text('Отправить'),
            ),
          ],
        );
      },
    );
  }

  String _generateCheckoutMessage(String place, String name, String phone,
      String postOffice, List<CartItem> items) {
    String message = '$name\n$phone\n$postOffice\n$place\n\n';

    // Group items by brand title
    var groupedItems = <String, List<CartItem>>{};
    for (var item in items) {
      if (!groupedItems.containsKey(item.title)) {
        groupedItems[item.title] = [];
      }
      groupedItems[item.title]!.add(item);
    }

    // Format each group
    groupedItems.forEach((title, items) {
      message += '$title:\n';
      for (var item in items) {
        message += '${item.title} (${item.quantity} шт)\n';
      }
      message += '\n';
    });

    return message;
  }

  void _copyToClipboard(BuildContext context, String message) {
    final clipboard = Clipboard.setData(ClipboardData(text: message));
    clipboard.then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Сообщение скопировано в буфер обмена'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }
}

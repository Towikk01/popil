import 'package:flutter/material.dart';
import 'package:popil/core/theme/app_colors.dart';
import 'package:popil/core/bloc/cart_bloc/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemListTile extends StatelessWidget {
  final CartItem item;

  const CartItemListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.orange),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        key: ValueKey(
            item.title), // Assign a unique key based on the item's title
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.imageUrl),
          radius: 24, // Adjust size as needed
        ),
        title: Text(
          item.title.trim(),
          style: const TextStyle(color: Colors.white, fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          'Цена: ${item.price.trim()}',
          style: const TextStyle(color: Colors.white),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                    onPressed: () {
                      context.read<CartBloc>().add(RemoveItemFromCart(item));
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    icon: const Icon(Icons.add_circle, color: Colors.green),
                    onPressed: () {
                      context.read<CartBloc>().add(AddItemToCart(item));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'x${item.quantity}',
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

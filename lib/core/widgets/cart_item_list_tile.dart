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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CartBloc>().add(RemoveItemFromCart(item));
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${item.quantity}',
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    context.read<CartBloc>().add(AddItemToCart(item));
                  },
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

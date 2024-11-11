import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> cartItems = [];

  CartBloc() : super(CartSuccess(items: [])) {
    on<AddItemToCart>((event, emit) {
      final existingItem = cartItems.firstWhere(
        (item) => item.title == event.item.title,
        orElse: () => CartItem(
          imageUrl: event.item.imageUrl,
          title: event.item.title,
          price: event.item.price,
          quantity: 0,
        ),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        event.item.quantity = 1;
        cartItems.add(event.item);
      }

      emit(CartSuccess(items: List.from(cartItems))); // Emit updated cart list
    });

    on<RemoveItemFromCart>((event, emit) {
      final existingItem = cartItems.firstWhere(
        (item) => item.title == event.item.title,
        orElse: () => CartItem(
          imageUrl: event.item.imageUrl,
          title: event.item.title,
          price: event.item.price,
          quantity: 0,
        ),
      );

      if (existingItem.quantity > 1) {
        existingItem.quantity--;
      } else {
        cartItems.removeWhere((item) => item.title == event.item.title);
      }

      emit(CartSuccess(items: List.from(cartItems))); // Emit updated cart list
    });
  }
}

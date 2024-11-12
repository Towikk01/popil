import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartSuccess(items: const [])) {
    on<AddItemToCart>(_addItemToCart);
    on<RemoveItemFromCart>(_removeItemFromCart);
  }

  void _addItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    if (state is CartSuccess) {
      final List<CartItem> updatedItems =
          List.from((state as CartSuccess).items);
      final index = updatedItems.indexWhere((item) => item.id == event.item.id);

      if (index >= 0) {
        // Increment quantity of existing item
        updatedItems[index] = updatedItems[index].copyWith(
          quantity: updatedItems[index].quantity + 1,
        );
      } else {
        // Add new item
        updatedItems.add(event.item.copyWith(quantity: 1));
      }

      emit(CartSuccess(items: updatedItems));
    }
  }

  void _removeItemFromCart(RemoveItemFromCart event, Emitter<CartState> emit) {
    if (state is CartSuccess) {
      final List<CartItem> updatedItems =
          List.from((state as CartSuccess).items);
      final index = updatedItems.indexWhere((item) => item.id == event.item.id);

      if (index >= 0) {
        final currentQuantity = updatedItems[index].quantity;
        if (currentQuantity > 1) {
          updatedItems[index] = updatedItems[index].copyWith(
            quantity: currentQuantity - 1,
          );
        } else {
          updatedItems.removeAt(index); // Remove if quantity is 1
        }
      }

      emit(CartSuccess(items: updatedItems));
    }
  }
}

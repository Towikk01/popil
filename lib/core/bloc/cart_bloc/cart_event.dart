part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {}

class AddItemToCart extends CartEvent {
  final CartItem item;

  AddItemToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final CartItem item;

  RemoveItemFromCart(this.item);

  @override
  List<Object> get props => [item];
}

// class CartCheckoutEvent extends CartEvent {
//   CartCheckoutEvent();

//   @override

//   List<Object?> get props => throw UnimplementedError();
// }

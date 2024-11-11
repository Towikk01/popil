part of 'cart_bloc.dart';

abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartSuccess extends CartState {
  final List<CartItem> items;
  CartSuccess({required this.items});

  @override
  List<Object> get props => [items];
}

class CartFailure extends CartState {
  final String errorMessage;

  CartFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class CartItem {
  final String imageUrl;
  final String title;
  final String price;
  int quantity;

  CartItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity = 1,
  });
}

// class CartCheckoutSuccess extends CartState {
//   CartCheckoutSuccess();

//   @override
//   List<Object?> get props => throw UnimplementedError();
// }

// class CartCheckoutFailure extends CartState {
//   final String errorMessage;

//   CartCheckoutFailure(this.errorMessage);

//   @override
//   List<Object> get props => [errorMessage];
// }

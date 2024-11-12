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

// ignore: must_be_immutable
class CartItem {
  final String id;
  final String imageUrl;
  final String title;
  final String price;
  final int quantity;

  CartItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      imageUrl: imageUrl,
      title: title,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
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

part of 'brands_bloc.dart';

@immutable
sealed class BrandsState extends Equatable {}

class BrandsInitial extends BrandsState {
  @override
  List<Object?> get props => [];
}

final class BrandsLoading extends BrandsState {
  @override
  List<Object?> get props => [];
}

final class BrandsSuccess extends BrandsState {
  final List<Map> brands;
  BrandsSuccess(this.brands);

  @override
  List<Object?> get props => [brands];
}

final class BrandsFailure extends BrandsState {
  final String errorMessage;
  BrandsFailure(this.errorMessage);

  @override
  List<Object?> get props =>
      [errorMessage]; // Now it properly implements `props`
}

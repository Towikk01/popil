part of 'brands_bloc.dart';

@immutable
abstract class BrandsEvent {}

class LoadBrands extends BrandsEvent {
  final bool isRefresh;

  LoadBrands({this.isRefresh = false});
}

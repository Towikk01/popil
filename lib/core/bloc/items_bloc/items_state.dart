part of 'items_bloc.dart';

@immutable
abstract class ItemsState extends Equatable {}

class ItemsInitial extends ItemsState {
  @override
  List<Object> get props => [];
}

class ItemsLoading extends ItemsState {
  @override
  List<Object> get props => [];
}

class ItemsSuccess extends ItemsState {
  final List<Map<String, dynamic>> items;
  final int currentPage;
  final bool isLastPage;
  final List<Map<String, dynamic>>? categories;
  final String filteredLink; // Store the current link with filters

  ItemsSuccess({
    required this.items,
    this.categories,
    required this.isLastPage,
    required this.currentPage,
    required this.filteredLink,
  });

  @override
  List<Object> get props => [items, currentPage, isLastPage, filteredLink];
}


class ItemsFailure extends ItemsState {
  final String errorMessage;

  ItemsFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

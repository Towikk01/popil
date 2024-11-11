import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:popil/core/utils/product_service.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ProductService productService;

  ItemsBloc({required this.productService}) : super(ItemsInitial()) {
    on<LoadItems>((event, emit) async {
      emit(ItemsLoading());

      try {
        final products =
            await productService.fetchProducts(event.link, event.page);

        emit(ItemsSuccess(
          items: products['items'],
          categories: products['categories'],
          currentPage: event.page,
          isLastPage: products['isLastPage'],
          filteredLink: event.link,
        ));
      } catch (error) {
        emit(ItemsFailure('Failed to load products'));
      }
    });

    on<LoadNextPage>((event, emit) async {
      if (state is ItemsSuccess) {
        final currentState = state as ItemsSuccess;

        if (!currentState.isLastPage) {
          final nextPage = currentState.currentPage + 1;

          try {
            // Use `filteredLink` from the current state to maintain filter
            final products = await productService.fetchProducts(
                currentState.filteredLink, nextPage);

            emit(ItemsSuccess(
              items: [
                ...currentState.items,
                ...products['items'],
              ],
              currentPage: nextPage,
              isLastPage: products['isLastPage'],
              filteredLink: currentState.filteredLink, // Persist filtered link
            ));
          } catch (error) {
            emit(ItemsFailure('Failed to load more products'));
          }
        }
      }
    });
  }
}

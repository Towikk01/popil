import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:popil/core/utils/product_service.dart';

part 'brands_event.dart';
part 'brands_state.dart';

class BrandsBloc extends Bloc<BrandsEvent, BrandsState> {
  final Dio dio;

  BrandsBloc({required this.dio}) : super(BrandsInitial()) {
    on<LoadBrands>(_onLoadBrands);
  }

  Future<void> _onLoadBrands(
      LoadBrands event, Emitter<BrandsState> emit) async {
    if (!event.isRefresh) {
      emit(BrandsLoading()); // Emit loading only for non-refresh events
    }

    try {
      final brandsList =
          await ProductService(dio).fetchBrands('https://popil.com.ua/tyutyun');
      emit(BrandsSuccess(brandsList));
    } catch (e) {
      emit(BrandsFailure('Failed to load brands: $e'));
    }
  }
}

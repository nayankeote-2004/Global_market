import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../repositories/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductLoading()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (_) {
        emit(ProductError('Failed to fetch products'));
      }
    });
  }
}

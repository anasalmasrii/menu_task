part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductSuccessState extends ProductState {
  ProductModel Productmodel = ProductModel();

  ProductSuccessState({
    required this.Productmodel,
  });
}

class ProductErrorState extends ProductState {
  final String? error;

  ProductErrorState({this.error});
}

class ProductFailureState extends ProductState {}

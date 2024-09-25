part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class ProductLoadingEvent extends ProductEvent {}

class ProductSuccessEvent extends ProductEvent {
  ProductModel Productmodel = ProductModel();
  ProductSuccessEvent({
    required this.Productmodel,
  });
}

class ProductErrorEvent extends ProductEvent {
  final String? error;

  ProductErrorEvent({this.error});
}

class ProductFailureEvent extends ProductEvent {}

class ProductVerifyUserEvent extends ProductEvent {}

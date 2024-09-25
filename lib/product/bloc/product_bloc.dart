import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:menu_task/poducts.dart';
import 'package:menu_task/product/bloc/product_repo.dart';
import 'package:menu_task/utility.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> with Utility {
  final MenuRepository menuRepository = MenuRepository();
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ProductLoadingEvent>((event, emit) {
      emit.call(ProductLoadingState());
    });
    on<ProductSuccessEvent>((event, emit) {
      emit.call(ProductSuccessState(Productmodel: event.Productmodel));
    });
    on<ProductErrorEvent>((event, emit) {
      emit.call(ProductErrorState());
    });
    on<ProductFailureEvent>((event, emit) {
      emit.call(ProductFailureState());
    });

    on<ProductVerifyUserEvent>((event, emit) {
      _ProductVerifyUser(event);
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> _ProductVerifyUser(ProductVerifyUserEvent event) async {
    add(ProductLoadingEvent());

    /// Call API from Login repository

    try {
      menuRepository.ProductRepoFuture().then((value) {
        if (value.products!.length > 0) {
          add(ProductSuccessEvent(Productmodel: value));
        } else {
          add(ProductErrorEvent(error: 'Error'));

//log(value.message.toString());
        }
      });
    } catch (e) {
      //   errorLog(e.toString());

      add(ProductErrorEvent(error: 'حدث خطأ ما يرجى المحاولة لاحقا'));
    }
  }
}

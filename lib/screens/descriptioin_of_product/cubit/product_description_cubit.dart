import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/web-services/dio_helper.dart';

import '../../../common-use/reusable_components.dart';

part 'product_description_state.dart';

class ProductDescriptionCubit extends Cubit<ProductDescriptionState> {
  ProductDescriptionCubit() : super(ProductDescriptionInitial());

  static ProductDescriptionCubit get(BuildContext context)=>BlocProvider.of(context);
  int index=0;
  void changeIndeicatorIndex(int index){
    this.index=index;
    emit(ChangeDotsIndexState());
  }

  void addProductToCart(String id){
    emit(AddProductToCartLoadingState());
    DioHelper.post(path: CART,
      token: token,
      data: {"product_id":id}
    ).then((value) {
      emit(AddProductToCartSuccessfullyState());
      showToast("Added to cart Successfully");
    }).catchError((error){
      emit(AddProductToCartErrorState());
      print(error);
    });
  }


}

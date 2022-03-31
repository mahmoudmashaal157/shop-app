import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/web-services/dio_helper.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(BuildContext context)=>BlocProvider.of(context);

  List<ProductModel>cartProducts=[];
  String? subTotal;
  String? total;

  void getCartProducts(){
    cartProducts=[];
    emit(GetCartProductsLoadingState());
    DioHelper.get(path: CART,token: token).then((value) {

      print(value.data['data']['total']);
      total =value.data['data']['total'].toString();

      value.data['data']['cart_items'].forEach((element){
        cartProducts.add(ProductModel.fromJson(element['product']));
      });
      emit(GetCartProductsSuccessfullyState());
    }).catchError((error){
      emit(GetCartProductsErrorState());
      print(error);
    });
  }

  void removeItemFromCart(String id){
    emit(RemoveItemFromCartLoadingState());
    DioHelper.post(path: CART,
        token: token,
        data: {"product_id":id}
    ).then((value) {
      cartProducts.removeWhere((element) => element.id==id);
      getCartProducts();
      emit(RemoveItemFromCartSuccessfullyState());
    }).catchError((error){
      emit(RemoveItemFromCartErrorState());
      print(error);
    });
  }

}

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/local-services/cache_helper.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/web-services/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get (BuildContext context)=>BlocProvider.of(context);

  List<ProductModel>products=[];
  Map<String,bool>favorite={};

  void getProducts(){
    emit(GetProductsLoadingState());
    DioHelper.get(
    path: PRODUCTS,
    token: token,
    ).then((value) {
      value.data['data']['data'].forEach((element){
        products.add(ProductModel.fromJson(element));
        favorite["${element['id']}"] = element['in_favorites'];
      });
      print(products.length);
      emit(GetProductsSuccessfullyState());
      print(token);
    }).catchError((error){
      emit(GetProductsErrorState());
      print(error);
    });
  }

  void RemoveOrAddProductToFavorite({required String id}){
    DioHelper.post(
      path: FAVORITES,
      token: token,
      data: {"product_id":id}
    ).then((value) {
      emit(AddItemToFavoriteSuccessfully());
    }).catchError((error){
      print(error);
      emit(AddItemToFavoriteError());
    });
  }

  void changeFavoriteColor(String id){
    if(favorite[id]==true) favorite[id]=false;
    else favorite[id]=true;
    emit(ChangeFavoriteColor());
    RemoveOrAddProductToFavorite(id: id);
  }


}

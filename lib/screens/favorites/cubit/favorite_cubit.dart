import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/models/product_model.dart';
import 'package:shopping/web-services/dio_helper.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  static FavoriteCubit get(BuildContext context)=>BlocProvider.of(context);

  List<ProductModel>products=[];
  Map<String,bool>favorite={};

  void getFavoriteProducts(){
    emit(GetFavortieProductsLoadingState());
    DioHelper.get(path: FAVORITES,token: token).then((value) {
      value.data['data']['data'].forEach((element){
        products.add(ProductModel.fromJson(element['product']));
        favorite["${element['product']['id']}"]=true;
      });
      emit(GetFavortieProductsSuccessfullyState());
    }).catchError((error){
      emit(GetFavortieProductsErrorState());
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
      emit(AddItemToFavoriteError());
      print(error);
    });
  }

  void changeFavoriteColor(String id){
    if(favorite[id]==true) favorite[id]=false;
    else favorite[id]=true;
    emit(ChangeFavoriteColor());
    RemoveOrAddProductToFavorite(id: id);
  }


}

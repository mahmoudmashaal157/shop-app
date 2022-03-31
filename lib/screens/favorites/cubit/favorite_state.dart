part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}

class GetFavortieProductsLoadingState extends FavoriteState{}

class GetFavortieProductsSuccessfullyState extends FavoriteState{}

class GetFavortieProductsErrorState extends FavoriteState{}

class AddItemToFavoriteSuccessfully extends FavoriteState{}

class AddItemToFavoriteError extends FavoriteState{}

class ChangeFavoriteColor extends FavoriteState{}


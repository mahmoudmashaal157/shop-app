part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LogoutLoadingState extends HomeState{}

class GetProductsLoadingState extends HomeState{}

class GetProductsSuccessfullyState extends HomeState{}

class GetProductsErrorState extends HomeState{}

class AddItemToFavoriteSuccessfully extends HomeState{}

class AddItemToFavoriteError extends HomeState{}

class ChangeFavoriteColor extends HomeState{}



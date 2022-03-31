part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class GetCartProductsLoadingState extends CartState{}

class GetCartProductsSuccessfullyState extends CartState{}

class GetCartProductsErrorState extends CartState{}

class RemoveItemFromCartLoadingState extends CartState{}

class RemoveItemFromCartSuccessfullyState extends CartState{}

class RemoveItemFromCartErrorState extends CartState{}

part of 'product_description_cubit.dart';

@immutable
abstract class ProductDescriptionState {}

class ProductDescriptionInitial extends ProductDescriptionState {}

class ChangeDotsIndexState extends ProductDescriptionState{}

class AddProductToCartLoadingState extends ProductDescriptionState{}

class AddProductToCartSuccessfullyState extends ProductDescriptionState{}

class AddProductToCartErrorState extends ProductDescriptionState{}


part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class ChangePasswordVisiblity extends RegisterState{}

class RegisterLoadingState extends RegisterState{}

class RegisterSuccessfullyState extends RegisterState{}

class RegisterErrorState extends RegisterState{}

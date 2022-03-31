part of 'edit_profile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState{}

class EditProfileSuccessfullyState extends EditProfileState{}

class EditProfileErrorState extends EditProfileState{}

class ImagePickedFromGallery extends EditProfileState{}


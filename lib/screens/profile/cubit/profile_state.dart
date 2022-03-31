abstract class ProfileState {}

class InitialState extends ProfileState{}

class GetProfileDataLoadingState extends ProfileState{}

class GetProfileDataSuccessfullyState extends ProfileState{}

class GetProfileDataErrorState extends ProfileState{}

class LogoutSuccessfullyState extends ProfileState{}

class LogoutErrorState extends ProfileState{}
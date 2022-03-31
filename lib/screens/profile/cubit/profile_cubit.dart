import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/models/profile_model.dart';
import 'package:shopping/screens/profile/cubit/profile_state.dart';
import 'package:shopping/web-services/dio_helper.dart';

import '../../../local-services/cache_helper.dart';

class ProfileCubit extends Cubit<ProfileState>{
  ProfileCubit() : super(InitialState());

  static ProfileCubit get(BuildContext context)=>BlocProvider.of(context);

  ProfileModel? profileData;

  void getProfileData()async{
    emit(GetProfileDataLoadingState());
    await DioHelper.get(path: PROFILE,token: token).then((value) {
      profileData = ProfileModel.fromJson(value.data['data']);
      print(token);
      print(value.data['data']);
      print(profileData!.name);
      emit(GetProfileDataSuccessfullyState());
    }).catchError((error){
      print(error.toString());
      emit(GetProfileDataErrorState());
    });
  }

  void logout(){
    DioHelper.post(path: LOGOUT,token: token).then((value) {
      token="";
      CacheHelper.removeData(key: "token");
      emit(LogoutSuccessfullyState());
    }).catchError((error){
      print(error.toString());
      emit(LogoutErrorState());
    });
  }

}
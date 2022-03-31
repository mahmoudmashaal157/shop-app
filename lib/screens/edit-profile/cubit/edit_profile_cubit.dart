import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/models/profile_model.dart';
import 'package:shopping/web-services/dio_helper.dart';


part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  static EditProfileCubit get(BuildContext context)=>BlocProvider.of(context);
  File? image;

  void pickImageFromGallery()async{
    final ImagePicker _picker = ImagePicker();
    final pickedFile = (await _picker.pickImage(source: ImageSource.gallery));
    if(pickedFile!=null)
    image = File(pickedFile.path);

    emit(ImagePickedFromGallery());
  }


  
  void updateProfile({
    required String name,
    required String email,
    required String phone,
  })async{
      emit(EditProfileLoadingState());
      Map<String, dynamic>data = ProfileModel.toMap(
          name: name, phone: phone, email: email);
      DioHelper.put(path: UPDATE_PROFILE, data: data, token: token).then((
          value) {
        print(value);
        showToast(value.data['message']);
        emit(EditProfileSuccessfullyState());
      }).catchError((error) {
        print(error.toString());
        emit(EditProfileErrorState());
      });


  }
}

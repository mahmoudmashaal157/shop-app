import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/local-services/cache_helper.dart';
import 'package:shopping/models/register_model.dart';
import 'package:shopping/web-services/dio_helper.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  bool passwordVisiblity=true;
  bool status=false;

   changePasswordVisiblity(){
    passwordVisiblity=!passwordVisiblity;
    emit(ChangePasswordVisiblity());
  }

  void registeration({
    required String name,
    required String phone,
    required String email,
    required String password,
  })async
  {
    emit(RegisterLoadingState());
    RegisterModel registerModel = RegisterModel(name,email, password, phone);
    Map<String,dynamic>data = registerModel.toMap();
    await DioHelper.post(path: REGISTER, data: data).then((value){
      if(value.data['status']==false){
        showToast("${value.data['message']}");
      }
      status = value.data['status'];
      token = value.data['data']['token'];
      print(token);
      CacheHelper.saveData(key: "token", value: token);

      emit(RegisterSuccessfullyState());
    }).catchError((error){
      emit(RegisterErrorState());
      print(error.toString());
    });
  }
}

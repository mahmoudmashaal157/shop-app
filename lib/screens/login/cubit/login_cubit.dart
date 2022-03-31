import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/local-services/cache_helper.dart';
import 'package:shopping/models/login_model.dart';
import 'package:shopping/web-services/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(BuildContext context)=>BlocProvider.of(context);

  bool passwordVisiblity=true;
  bool status = false;

  changePasswordVisiblity(){
    passwordVisiblity=!passwordVisiblity;
    emit(ChangePasswordVisiblityState());
  }

  void login({
    required String email,
    required String password
  })async
  {
    emit(LoginLoadingState());

    LoginModel loginData = LoginModel(email, password);
    Map<String,dynamic>data = loginData.toMap();

    await DioHelper.post(path: LOGIN, data: data).then((value) {
      showToast("${value.data['message']}");
      status = value.data['status'];
      token = value.data['data']['token'];
      CacheHelper.saveData(key: "token", value:token);
      print(token);
      emit(LoginSuccessfullyState());
    }).catchError((error){
      emit(LoginErrorState());
      print(error.toString());
    });
  }
}

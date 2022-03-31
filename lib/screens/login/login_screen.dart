import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/common-use/reusable_functions.dart';
import 'package:shopping/screens/bottom-nav-bar-layout/layout.dart';
import 'package:shopping/screens/home/home_screen.dart';
import 'package:shopping/screens/login/cubit/login_cubit.dart';
import 'package:shopping/screens/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Text(
                      "Login",
                      style: textStyle(fontSize:50,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ReusableTextFormField(
                      labelText: 'Email',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validation: (String s) {
                        if (s.isEmpty) return "please enter your email";
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return ReusableTextFormField(
                          labelText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          prefixIcon: Icons.lock,
                          suffixIcon: Icons.remove_red_eye,
                          controller: passwordController,
                          ispassword: LoginCubit.get(context).passwordVisiblity,
                          onSuffixPressed: ()=>LoginCubit.get(context).changePasswordVisiblity(),
                          validation: (String s) {
                            if (s.isEmpty) return "please enter your password";
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                        if(LoginCubit.get(context).status==true){
                          navigateAndReplacment(context, Layout());
                        }
                        LoginCubit.get(context).status=false;
                        LoginCubit.get(context).passwordVisiblity=false;
                      },
                      builder: (context, state) {
                        return
                          state is LoginLoadingState ?
                          CircularProgressIndicator() :
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    LoginCubit.get(context).login(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }

                                },
                                child: Text("Login")),
                          );
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account",
                          style: textStyle(fontSize:20, fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text(
                              "Register",
                              style: textStyle(fontSize:20, fontWeight:FontWeight.normal),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

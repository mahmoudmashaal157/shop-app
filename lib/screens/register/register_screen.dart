import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/common-use/reusable_functions.dart';
import 'package:shopping/screens/home/home_screen.dart';

import 'cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => RegisterCubit(),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    "Register",
                    style: textStyle(fontSize: 50, fontWeight:FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ReusableTextFormField(
                    labelText: 'Name',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.drive_file_rename_outline,
                    controller: nameController,
                    validation: (String s) {
                      if (s.isEmpty) return "please enter your name";
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ReusableTextFormField(
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: Icons.email,
                    controller: emailController,
                    validation: (String s) {
                      if (s.isEmpty) return "please enter your Email";
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ReusableTextFormField(
                    labelText: 'phone',
                    keyboardType: TextInputType.number,
                    prefixIcon: Icons.phone,
                    controller: phoneController,
                    validation: (String s) {
                      if (s.isEmpty) return "please enter your phone";
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return ReusableTextFormField(
                        labelText: 'Password',
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: Icons.lock,
                        suffixIcon: Icons.remove_red_eye,
                        controller: passwordController,
                        ispassword: RegisterCubit.get(context).passwordVisiblity,
                        onSuffixPressed:()=>RegisterCubit.get(context).changePasswordVisiblity(),
                        validation: (String s) {
                          if (s.isEmpty) return "please enter your Password";
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ReusableTextFormField(
                    labelText: 'Confirm Password',
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock,
                    controller: confirmPasswordController,
                    ispassword: true,
                    validation: (String s) {
                      if (s.isEmpty)
                        return "please enter your Confirmation password";
                      else if (passwordController.text !=
                          confirmPasswordController.text)
                        return "Password don't match";
                    },
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  BlocConsumer<RegisterCubit, RegisterState>(
                    listener: (context, state) {
                      if(RegisterCubit.get(context).status==true){
                        navigateAndReplacment(context, HomeScreen());
                      }
                      RegisterCubit.get(context).status=false;
                      RegisterCubit.get(context).passwordVisiblity=false;
                    },
                    builder: (context, state) {
                      return
                        state is RegisterLoadingState ?
                        CircularProgressIndicator() :
                        Container(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  RegisterCubit.get(context).registeration(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              child: Text("SignUp")),
                        );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  void pri(){
    print("fdfd");
  }
}

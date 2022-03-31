
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/screens/edit-profile/cubit/edit_profile_cubit.dart';


class EditProfileScreen extends StatelessWidget {
  late String name;
  late String email;
  late String image;
  late String phone;

  EditProfileScreen({required this.name,
    required this.email,
    required this.image,
    required this.phone});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = name;
    emailController.text = email;
    phoneController.text = phone;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: BlocProvider(
        create: (context) => EditProfileCubit(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<EditProfileCubit, EditProfileState>(
                  builder: (context, state) {
                    EditProfileCubit cubit = EditProfileCubit.get(context);
                    return Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage: 
                          cubit.image==null?
                          NetworkImage("${image}"):
                          FileImage(cubit.image!) as ImageProvider,
                          radius: 80,
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: IconButton(
                            onPressed: () {
                              cubit.pickImageFromGallery();
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableTextFormField(
                  labelText: "Name",
                  keyboardType: TextInputType.name,
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                ReusableTextFormField(
                    labelText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController),
                SizedBox(
                  height: 20,
                ),
                ReusableTextFormField(
                    labelText: "Phone",
                    keyboardType: TextInputType.phone,
                    controller: phoneController),
                SizedBox(
                  height: 60,
                ),
                BlocConsumer<EditProfileCubit, EditProfileState>(
                  listener: (context, state) {
                    if (state is EditProfileSuccessfullyState) {}
                  },
                  builder: (context, state) {
                    return
                      state is! EditProfileLoadingState ?
                      Container(
                        width: 120,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              EditProfileCubit.get(context).updateProfile(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            },
                            child: Text("Update")),
                      ) :
                      Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

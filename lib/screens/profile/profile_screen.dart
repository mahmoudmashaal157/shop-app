import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/common-use/constants.dart';
import 'package:shopping/common-use/reusable_components.dart';
import 'package:shopping/common-use/reusable_functions.dart';
import 'package:shopping/screens/edit-profile/edit_profile_screen.dart';
import 'package:shopping/screens/login/login_screen.dart';
import 'package:shopping/screens/profile/cubit/profile_cubit.dart';
import 'package:shopping/screens/profile/cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfileData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          actions: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return TextButton(
                    onPressed: () {
                      navigateAndReplacment(context, LoginScreen());
                    },
                    child: Text(
                      "Logout",
                      style: textStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ));
              },
            ),
          ],
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            ProfileCubit cubit = ProfileCubit.get(context);
            return cubit.profileData == null
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color(0xfff85465),
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage:
                        NetworkImage("${cubit.profileData!.image}"),
                        radius: 80,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          color: mainColor,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "credit",
                                  style: textStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "${cubit.profileData!.credit}\$",
                                  style: textStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 50,
                      width: 1,
                    ),
                    Expanded(
                        child: Container(
                          color:mainColor,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "points",
                                  style: textStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "${cubit.profileData!.points}",
                                  style: textStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                              Icon(Icons.drive_file_rename_outline)),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "${cubit.profileData!.name}",
                                style: textStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Icon(Icons.email)),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "${cubit.profileData!.email}",
                                style: textStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(flex: 1, child: Icon(Icons.phone)),
                          Expanded(
                              flex: 5,
                              child: Text(
                                "${cubit.profileData!.phone}",
                                style: textStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {
                      _awaitReturnFromEditProfileScreen(
                        context: context,
                        image: cubit.profileData!.image.toString(),
                        email: cubit.profileData!.email.toString(),
                        name: cubit.profileData!.name.toString(),
                        phone: cubit.profileData!.phone.toString(),
                      );
                    },
                    child: Text("Edit"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _awaitReturnFromEditProfileScreen({required BuildContext context,
    required String image,
    required String email,
    required String name,
    required String phone}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfileScreen(
        image: image.toString(),
        email: email.toString(),
        name: name.toString(),
        phone: phone.toString(),
      );
    }));
    ProfileCubit.get(context).getProfileData();
  }
}

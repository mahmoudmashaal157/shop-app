import 'dart:io';

import 'package:dio/dio.dart';

class ProfileModel{
  String? name;
  String? email;
  String? phone;
  String? image;
  int? credit;
  int? points;

  ProfileModel({required this.name, required this.email, required this.phone,required this.image,required this.credit,required this.points});

  ProfileModel.fromJson(Map<String,dynamic>data){
    name=data['name'];
    email=data['email'];
    phone=data['phone'];
    image=data['image'];
    credit=data['credit'];
    points=data['points'];
  }

  static Map<String,dynamic>toMap({
    required String name,
    required String phone,
    required String email,
     File? image,
  }){
    if(image!=null)
    return {
      "name":name,
      "email":email,
      "phone":phone,
      "image":image,
    };
    else {
      return {
        "name":name,
        "email":email,
        "phone":phone,
      };
    }
  }
}
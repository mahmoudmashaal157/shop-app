import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReusableTextFormField extends StatelessWidget {

  late String labelText;
  late TextInputType keyboardType;

  IconData? prefixIcon;
  IconData? suffixIcon;


  Function? validation;
  Function? onSuffixPressed;

  bool? ispassword = false;
  TextEditingController? controller;

  ReusableTextFormField({
    required this.labelText, this.prefixIcon, this.suffixIcon,required this.keyboardType,
  this.validation, this.ispassword=false, this.controller,this.onSuffixPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: ispassword!,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: "$labelText",
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefixIcon==null? null : prefixIcon),
        suffixIcon: IconButton(
          onPressed:(){
            onSuffixPressed!();
          },
          icon:Icon(suffixIcon==null? null :suffixIcon),
        ),
      ),
      validator: (s){
        return validation!(s);
      },
    );
  }
}

TextStyle textStyle({double? fontSize,FontWeight? fontWeight,Color? color, TextOverflow? overflow}){
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    overflow: overflow,

  );
}

showToast (String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void navigateTo(BuildContext context , Widget screen) {
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return screen;
      })
  );
}

  void navigateAndReplacment(BuildContext context , Widget screen) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return screen;
        })
    );
  }

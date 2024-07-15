import 'package:cta/Pages/Assement_Page/Assesment_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logincontroller extends GetxController {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();

  bool isSignedin = false;

  void signuserin() {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      isSignedin = true;
      update();
      Get.to((AssessmentPage()));
    });
  }

  void sigUserUp() {
    String email = emailcontroller.text.trim();
    String password = passwordcontroller.text.trim();
    String confirmpassword = confirmpasswordcontroller.text.trim();

    if (password == confirmpassword) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isSignedin = true;
        update();
        Get.to((AssessmentPage()));
      });
    } else {
      throw Exception('Passwords do not match');
    }
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/controller/login_controller.dart';


class ConnectionToServer {
    final logInController = Get.put(LogInController());

  // this is the ip adddress of the connected internet.
  static String ipData = '192.168.76.77';
   late var prefs;
  //add user to the table 'user'
  registerUser(name, email, type, password, context) async {
    var data = {
      'name': name,
      'email': email,
      'type': type,
      'password': password
    };
    var response = await http.post(
        Uri.parse('http://$ipData/project/register_user.php'),
        body: data);
    if (json.decode(response.body)) {
      _snackBar('Email is already registered',context);
    }
    else{
      // logInController.logIn();
    }
  }

  //to crosscheck while login
  crossCheckUser(email, password, context) async {
    var data = {'email': email, 'password': password};
    var response = await http.post(
        Uri.parse('http://$ipData/project/crosscheck_user.php'),
        body: data);

    //If the email is not registered
    if (!json.decode(response.body)) {
      _snackBar('User Doesn\'t Exist', context);
    }
    else{
      logInController.logIn();
    }
  }


  //was giving errow when tried to pass the bool value
  void _snackBar(msg, context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      duration: const Duration(seconds: 3),
    ));
  }
}

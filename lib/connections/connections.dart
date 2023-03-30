import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project/controller/login_controller.dart';

class ConnectionToServer {
  final logInController = Get.put(LogInController());

  // this is the ip adddress of the connected internet.
  static String ipData = '192.168.51.77';

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
      _snackBar('Email is already registered', context);
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
    } else {
      logInController.logIn();
    }
  }

  addFreelancer(name, email, bio, title, exp, category, skill1, skill2, skill3,
      skill4, skill5) async {
    var data = {
      'name': name,
      'email': email,
      'bio': bio,
      'title': title,
      'experience': exp,
      'category': category,
      'skill_1': skill1,
      'skill_2': skill2,
      'skill_3': skill3,
      'skill_4': skill4,
      'skill_5': skill5,
    };
    await http.post(
        Uri.parse('http://$ipData/project/add_freelancer_details.php'),
        body: data);
    logInController.logIn();
  }

  addClinet(name, email, bio) async {
    var data = {'name': name, 'email': email, 'bio': bio};
    await http.post(Uri.parse('http://$ipData/project/add_client_details.php'),
        body: data);
    logInController.logIn();
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

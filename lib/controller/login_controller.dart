import 'package:get/get.dart';

class LogInController extends GetxController {
  RxBool isLoggedIn = false.obs;
  void logIn() async {
    isLoggedIn(true);
  }

  void logOut() async {
    isLoggedIn(false);
  }
}

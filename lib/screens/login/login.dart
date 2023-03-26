import 'package:flutter/material.dart';
import '../../conatants/colors.dart';
import '../../connections/connections.dart';
import 'add_details.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late PageController pageController;

  late bool user;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController otp = TextEditingController();

  @override
  void initState() {
    pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [_bg(context), _content(context)],
      ),
    );
  }

  _bg(context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login/login_bg.jpg'),
              fit: BoxFit.cover)),
    );
  }

  _content(context) {
    final double progress =
        pageController.hasClients ? pageController.page ?? 0 : 0;
    return Container(
      height: MediaQuery.of(context).size.height * 0.4 + progress * 140,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          _whichUser(),
          _logInPage(),
          _signUpPage(),
          _emailVerification()
        ],
      ),
    );
  }

  _whichUser() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore The World \nOf Endless Opportunities..',
            style: TextStyle(fontSize: 25),
          ),
          Column(
            children: [
              MaterialButton(
                height: 45,
                minWidth: double.infinity,
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  user = true;
                  _forwardNav();
                },
                child: Text("I'm a Freelancer".toUpperCase()),
              ),
              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                color: ThemeColors().btnColor,
                textColor: Colors.white,
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                height: 45,
                onPressed: () {
                  user = false;
                  _forwardNav();
                },
                child: Text("I want to Hire".toUpperCase()),
              ),
            ],
          )
        ],
      ),
    );
  }

  _logInPage() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Log In',
            style: TextStyle(fontSize: 35),
          ),
          Column(
            children: [
              TextField(
                controller: email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline), hintText: 'Email'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: password,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline), hintText: 'Password'),
              ),
            ],
          ),
          TextButton(onPressed: () {}, child: const Text('Forgot Password ?')),
          MaterialButton(
            minWidth: double.infinity,
            height: 45,
            color: ThemeColors().btnColor,
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () {
              _loginValidation();
            },
            child: const Text('Log In'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _backBtn(),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  _forwardNav();
                },
                child: const Text('Sign Up'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _signUpPage() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(fontSize: 35),
          ),
          Column(
            children: [
              TextField(
                controller: name,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person_3_outlined),
                    hintText: 'Name'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline), hintText: 'Email'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: password,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline), hintText: 'Password'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: passwordConfirm,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    hintText: 'Confirm Password'),
              ),
            ],
          ),
          MaterialButton(
            minWidth: double.infinity,
            height: 45,
            color: ThemeColors().btnColor,
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () {
              if (_signupValidation()) {
                _forwardNav();
              }
            },
            child: const Text('Sign Up'),
          ),
          _backBtn()
        ],
      ),
    );
  }

  _emailVerification() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Verification',
            style: TextStyle(fontSize: 35),
          ),
          Text('We have sent an OTP to ${email.text}'),
          const SizedBox(
            height: 35,
          ),
          TextField(
            controller: otp,
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.messenger_outline),
                hintText: 'OTP here'),
          ),
          const Spacer(),
          MaterialButton(
            minWidth: double.infinity,
            height: 45,
            color: ThemeColors().btnColor,
            textColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            onPressed: () {
              ConnectionToServer().registerUser(name.text, email.text,
                  (user) ? 'Freelancer' : 'Client', password.text, context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddUserDetails(userType: user)));
            },
            child: const Text('Verify'),
          ),
          const SizedBox(
            height: 35,
          ),
          _backBtn()
        ],
      ),
    );
  }

  _forwardNav() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 400), curve: Curves.ease);
  }

  _backBtn() {
    return IconButton(
      onPressed: () {
        pageController.previousPage(
            duration: const Duration(milliseconds: 400), curve: Curves.ease);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  _loginValidation() {
    if (email.text == '' || password.text == '') {
      _showSnack('Fill the details !!', Colors.redAccent);
    } else {
      ConnectionToServer().crossCheckUser(email.text, password.text, context);
    }
  }

  _signupValidation() {
    if (name.text == '' ||
        email.text == '' ||
        password.text == '' ||
        passwordConfirm.text == '') {
      _showSnack('Fill the details !!', Colors.redAccent);
      return false;
    } else if (password.text != passwordConfirm.text) {
      _showSnack('Passwords don\'t match', Colors.orangeAccent);
      return false;
    } else {
      return true;
    }
  }

  _showSnack(msg, color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      duration: const Duration(seconds: 3),
    ));
  }
}

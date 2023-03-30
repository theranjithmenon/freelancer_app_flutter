import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/connections/connections.dart';

import '../../conatants/colors.dart';

class AddUserDetails extends StatefulWidget {
  const AddUserDetails(
      {super.key,
      required this.userType,
      required this.name,
      required this.email});
  final bool userType;
  final String name;
  final String email;

  @override
  State<AddUserDetails> createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails> {
  File? _image;
  TextEditingController category = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController exp = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();
  TextEditingController skill5 = TextEditingController();

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  image() {
    if (_image == null) {
      return const NetworkImage(
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png');
    } else {
      return FileImage(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: (widget.userType) ? freelancerDetails() : clientDetails()),
      ),
    );
  }

  clientDetails() {
    return Column(
      children: [
        const Text('Hire Freelancers.', style: TextStyle(fontSize: 35)),
        const Text('Provide a basic intro to the freelancers about yourself.'),
        const SizedBox(
          height: 25,
        ),
        imagePick(),
        const SizedBox(
          height: 25,
        ),
        TextField(
          controller: bio,
          decoration: const InputDecoration(
              hintText: 'Bio', prefixIcon: Icon(Icons.description)),
        ),
        const SizedBox(
          height: 25,
        ),
        savebtn()
      ],
    );
  }

  freelancerDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Find Works',
            style: TextStyle(fontSize: 35),
          ),
          const Text('Build a portfolio first.'),
          const SizedBox(
            height: 25,
          ),
          profile(),
          const SizedBox(
            height: 25,
          ),
          TextField(
            controller: category,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintText: 'Category', prefixIcon: Icon(Icons.category)),
          ),
          TextField(
            controller: title,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintText: 'Title', prefixIcon: Icon(Icons.title)),
          ),
          TextField(
            controller: bio,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
                hintText: 'Bio', prefixIcon: Icon(Icons.description)),
          ),
          TextField(
            controller: exp,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
                hintText: 'Experiance', prefixIcon: Icon(Icons.work)),
          ),
          const SizedBox(
            height: 25,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Skills.',
                style: TextStyle(fontSize: 25),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: skill1,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Skill One',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      controller: skill2,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Skill Two',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: skill3,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Skill Three',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      controller: skill4,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Skill Four',
                      ),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: skill5,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  hintText: 'Skill Five',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          savebtn()
        ],
      ),
    );
  }

  imagePick() {
    return GestureDetector(
      onTap: getImage,
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            image: DecorationImage(image: image(), fit: BoxFit.cover),
            shape: BoxShape.circle,
            color: Colors.blueAccent),
      ),
    );
  }

  profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        imagePick(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.name,
              style: const TextStyle(fontSize: 20),
            ),
            Text(widget.email),
          ],
        )
      ],
    );
  }

  savebtn() {
    return MaterialButton(
      minWidth: double.infinity,
      height: 45,
      color: ThemeColors().btnColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      onPressed: () {
        if (widget.userType == true) {
          ConnectionToServer().addFreelancer(
              widget.name,
              widget.email,
              bio.text,
              title.text,
              exp.text,
              category.text,
              skill1.text,
              skill2.text,
              skill3.text,
              skill4.text,
              skill5.text);
        } else {
          ConnectionToServer().addClinet(widget.name, widget.email, bio.text);
        }
        Navigator.pop(context);
      },
      child: const Text('Save'),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddUserDetails extends StatefulWidget {
  const AddUserDetails({super.key, required this.userType});
  final bool userType;

  @override
  State<AddUserDetails> createState() => _AddUserDetailsState();
}

class _AddUserDetailsState extends State<AddUserDetails> {
  File? _image;
  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final tempImage = File(image.path);
      setState(() {
        _image = tempImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: getImage,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(image: image()),
                    shape: BoxShape.circle, color: Colors.blueAccent),
              ),
            )
          ],
        ),
      ),
    );
  }
  
  image() {
    if(_image == null){
      return const NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png');
    }else{
      Image.file(_image!);
    }
  }
}

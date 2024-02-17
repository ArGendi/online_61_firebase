import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_14/firebase_services/auth_services.dart';
import 'package:flutter_application_14/firebase_services/storage_services.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imageUrl;

  void getProfilePicture() async{
    String? url = await StorageServices().getFile();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              // AuthServices x = AuthServices();
              // x.logout();
              AuthServices().logout();
            }, 
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
              radius: 80,
              backgroundColor: Colors.grey,
            ),
            TextButton(
              onPressed: () async{
                ImagePicker picker = ImagePicker();
                XFile? xfile = await picker.pickImage(source: ImageSource.camera);
                if(xfile != null){
                  File image = File(xfile.path);
                  String? url = await StorageServices().uploadFile(image);
                  setState(() {
                    imageUrl = url;
                  });
                }
              },
              child: Text("Take image"),
            ),
          ],
        ),
      ),
    );
  }
}
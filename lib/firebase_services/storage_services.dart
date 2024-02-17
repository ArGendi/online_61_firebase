import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageServices{
  Future<String?> uploadFile(File file) async{
    try{
      String id = FirebaseAuth.instance.currentUser!.uid;
      UploadTask task = FirebaseStorage.instance.ref().child("profiles/$id.png").putFile(file);
      String url = await task.snapshot.ref.getDownloadURL();
      return url;
    }
    catch(e){
      return null;
    }
  }

  Future<String?> getFile() async{
    try{
      String id = FirebaseAuth.instance.currentUser!.uid;
      String url = await FirebaseStorage.instance.ref().child("$id.png").getDownloadURL();
      return url;
    }
    catch(e){
      return null;
    }
  }

  Future<List<String>?> getAllFiles() async{
    try{
      var results = await FirebaseStorage.instance.ref().child("profiles/").listAll();
      List<String> urls = [];
      for(var item in results.items){
        String url = await item.getDownloadURL();
        urls.add(url);
      }
      return urls;
    }
    catch(e){
      return null;
    }
  }
}
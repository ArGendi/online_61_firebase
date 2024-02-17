import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreServices{
  Future<bool> add(String name, String phone) async{
    try{
      await FirebaseFirestore.instance.collection("contacts").add({
        "name": name,
        "phone": phone,
      });
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<void> set(String name, String phone, String country) async{
    // set -> add / update
    String id = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection("contacts").doc(id).set({
      "name": name,
      "phone": phone,
      "country": country,
    });
  }

  Future<bool> delete() async{
    try{
      String id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("contacts").doc(id).delete();
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future<bool> update(String name, String phone, String country) async{
    try{
      String id = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("users").doc(id).update({
        "name": name,
        "phone": phone,
        "country": country,
      });
      return true;
    }
    catch(e){
      return false;
    }
  }

  Future< List<Map> > getData() async{
    var snapshot = await FirebaseFirestore.instance.collection("contacts").get();
    List<Map> contacts = [];
    for(var doc in snapshot.docs){
      Map<String, dynamic> contact = doc.data();
      contacts.add(contact);
    }
    return contacts;
  }

  Future<void> getDoc() async{
    var snapshot = await FirebaseFirestore.instance.collection("contacts").doc("yVUAdpmubZjDxQDX9LRv").get();
    if(snapshot.exists){
      snapshot.data();
    }
  }
}
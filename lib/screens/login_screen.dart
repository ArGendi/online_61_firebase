import 'package:flutter/material.dart';
import 'package:flutter_application_14/firebase_services/auth_services.dart';
import 'package:flutter_application_14/firebase_services/firestore_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                AuthServices authServices = AuthServices();
                authServices.login("abdo@gmail.com", "12345678").then((error){
                  if(error == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Logged in successfully"), backgroundColor: Colors.green,)
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error), backgroundColor: Colors.red,)
                    );
                  }
                });
              },
              child: Text("Login"),
            ),
             TextButton(
              onPressed: (){
                AuthServices authServices = AuthServices();
                authServices.register("mo@gmail.com", "12345678").then((error){
                  if(error == null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Account created successfully"), backgroundColor: Colors.green,)
                    );
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error), backgroundColor: Colors.red,)
                    );
                  }
                });
              },
              child: Text("Register"),
            ),
            TextButton(
              onPressed: (){
                AuthServices authServices = AuthServices();
                authServices.loginWithGoogle();
              },
              child: Text("Google"),
            ),
            TextButton(
              onPressed: () async{
                await AuthServices().register("ahmed@gmail.com", "12345678");
                await FirestoreServices().set("Ahmed Hassan", "0102226222", "Saudi Arabia");
              },
              child: Text("Sign up with extra data"),
            ),
          ],
        ),
      ),
    );
  }
}
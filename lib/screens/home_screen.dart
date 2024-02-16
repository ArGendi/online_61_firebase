import 'package:flutter/material.dart';
import 'package:flutter_application_14/firebase_services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        child: Text("Home"),
      ),
    );
  }
}
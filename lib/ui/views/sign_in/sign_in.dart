import 'package:flutter/material.dart';

class SignIn extends StatelessWidget{
  const SignIn({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: signIn(context)
    );
  }



  Widget signIn(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
        ),
        body: Center(
          child: Column(
            children: const [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true, // This hides the password
              ),
            ],
          ),
        ),
      ),
    );
  }


}
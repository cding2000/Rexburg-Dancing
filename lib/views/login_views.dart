import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devotools show log;


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      body: Column(
            children: [
              TextField(
                controller: _email,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here'
                ),
        
              ),
              TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here'
                ),
              ),
              TextButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    final userCredential = 
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, 
                      password: password,
                );
                    
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/venues/', 
                    (route) => false,);
    
                  } on FirebaseAuthException catch (e){
                    if (e.code == 'user-not-found'){
                      devotools.log('User not found');
                    }
                    else if (e.code == 'wrong password'){
                      devotools.log('Wrong password');
                    }
                  }  
                },
                child: const Text('Login'),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('/register/'
                  , (route) => false,
                  );
    
                }, 
                child: const Text('Not register yet? Register here.'),
                )
            ],
          ),
    );
  }
}


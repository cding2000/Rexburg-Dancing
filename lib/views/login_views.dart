import 'package:flutter/material.dart';

import 'package:rexburgdancing/constant/routs.dart';
import 'package:rexburgdancing/services/auth/auth_exception.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';

import '../utilities/error_dialog.dart';


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
                    await AuthService.firebase().logIn(email: email, password: password);
                    final user = AuthService.firebase().currentuser;

                    if(user?.isEmailVerfied ?? false){
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    venueRoute, 
                    (route) => false,);
                    }
                    else{
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    verfiyEmailRoute, 
                    (route) => false,);
                    }
    
                  } 
                  on UserNotFoundAuthException{await showErrorDialog(context, "user not found",);}
                  on WrongpasswordAuthException{await showErrorDialog(context, 'Wrong password',);}
                  on GenericAuthException{await showErrorDialog(context, 'Authentic error',);}
                },
                child: const Text('Login'),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(registerRoute
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

import 'package:flutter/material.dart';

import 'package:rexburgdancing/constant/routs.dart';
import 'package:rexburgdancing/services/auth/auth_exception.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import '../utilities/show_error_dialog.dart';


class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
      appBar: AppBar(title: const Text('Register'),),
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
                    await AuthService.firebase().createUser(email: email, password: password);
                    
                  AuthService.firebase().sendEmailVerification();
                  Navigator.of(context).pushNamed(verfiyEmailRoute);
                  } 
                  on WeakPasswordAuthException{
                    await showErrorDialog(context, "Weak password",);
                  }

                  on EmailAlreadyINUseAuthException{
                    await showErrorDialog(context, 'Email already taken, try log in',);
                  }
                  
                  on InvalidEmailAuthException{
                    await showErrorDialog(context, 'Invalid email',);
                  }

                  on GenericAuthException{
                    await showErrorDialog(context, 'Failed to register',);
                  }             
                },
                child: const Text('Register'),),
                TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute
                , (route) => false,
                );

              }, 
              child: const Text('Already Register? Login here.'),
              )
            ],
          ),
    );
  }
}


import 'package:flutter/material.dart';

import 'package:rexburgdancing/constant/routs.dart';
import 'package:rexburgdancing/services/auth/auth_exception.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';

import '../utilities/error_dialog.dart';


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
      body: 
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("accests/images/register_bg.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
      child: Column(
            children: [
              const SizedBox(height: 50),
              Image.asset('accests/images/cowboy-hat.png', height: 100,),
              const SizedBox(height: 20),
              const Text('welcome!',style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 175, 159, 11)),),
              const Text('Create New Account', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 175, 159, 11)),),
              const SizedBox(height: 20),
              TextField(
                controller: _email,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                  hintStyle: TextStyle(color: Color.fromRGBO(175, 159, 11, 1)),
                ),
        
              ),
              TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 175, 159, 11)),
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
                child: const Text('Register', style: TextStyle(color: Color.fromARGB(255, 175, 159, 11)),),),
                TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute
                , (route) => false,
                );

              }, 
              child: const Text('Already Register? Login here.', style: TextStyle(color: Color.fromARGB(255, 175, 159, 11)),),
              )
            ],
          ),
    ));
  }
}


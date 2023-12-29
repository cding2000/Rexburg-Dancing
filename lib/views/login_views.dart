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
      body: 
       Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("accests/images/dance.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
       child: Column(
            children: [
              const SizedBox(height: 50),
              const Icon(Icons.music_note, size: 100, color: Colors.brown,),
              const SizedBox(height: 20),
              const Text('WELCOME!', style: TextStyle(fontSize: 30, color: Colors.amber),),
              const Text('LOG IN', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.amber),),
              const SizedBox(height: 20),
              TextField(
                controller: _email,
                autocorrect: false,
                enableSuggestions: false,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.amber),
                decoration: const InputDecoration(
                  hintText: 'Enter your email here',
                  hintStyle: TextStyle(color: Colors.amber),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  ),
                ),
        
              ),
              TextField(
                controller: _password,
                obscureText: true,
                autocorrect: false,
                enableSuggestions: false,
                style: const TextStyle(color: Colors.amber),
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                  ),
                  hintText: 'Enter your password here',
                  hintStyle: TextStyle(color: Colors.amber),

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
                    danceListRoute,
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
                child: const Text('Login',style: TextStyle(color: Colors.amber),),
                ),
                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(resetPasswordRote
                  , (route) => false,
                  );
    
                }, 
                child: const Text('Reset password here.',style: TextStyle(color: Colors.amber),),
                ),
                

                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(registerRoute
                  , (route) => false,
                  );
    
                }, 
                child: const Text('Not register yet? Register here.',style: TextStyle(color: Colors.amber),),
                )
            ],
          ),
    ));
  }
}

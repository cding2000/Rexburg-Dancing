import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rexburgdancing/views/login_views.dart';
import 'package:rexburgdancing/views/register_views.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Home',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),

      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
                ),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
            return const LoginView();   
        default:
        return const CircularProgressIndicator();
          }
          
        },
      );
  }
}


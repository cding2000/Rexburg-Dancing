import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rexburgdancing/views/login_views.dart';
import 'package:rexburgdancing/views/register_views.dart';
import 'package:rexburgdancing/views/vierfy_email_view.dart';
import 'firebase_options.dart';
import 'dart:developer' as devotools show log;

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
            final user = FirebaseAuth.instance.currentUser;
            if (user != null){
              if (user.emailVerified){
                return const DanceVenueView();
              }
              else{ 
                return const VerfiyEmailView();}
            }
            else{
              return const LoginView();
            }
        default:
        return const CircularProgressIndicator();
          }
          
        },
      );
  }
}

enum MenuAction{
  logout
}

class DanceVenueView extends StatefulWidget {
  const DanceVenueView({super.key});

  @override
  State<DanceVenueView> createState() => _DanceVenueViewState();
}

class _DanceVenueViewState extends State<DanceVenueView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dance Venue In Rexburg'),
      actions: [
        PopupMenuButton<MenuAction>(onSelected: (value) async {
          switch (value)  {
            case MenuAction.logout:
              final shouldLogout = await showLogoutDialog(context);
              if (shouldLogout){
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false);
              }

          }
        },
        itemBuilder: (context)
        {
          return const 
          [ PopupMenuItem<MenuAction>(value: MenuAction.logout, child: Text('Log out')) ];
          
        },
        )
      ],
      ),
      body: const Text('Hello'),
      );
  }
}

Future<bool> showLogoutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder: (context){
      return AlertDialog(
      title: const Text("Sign out"),
      content: const Text('Are you sure you want yo log out?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, 
        child: const Text('Cancel')
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, 
        child: const Text('Logout')
        ),
      ],
      );
  },
  ).then((value) => value ?? false);

}
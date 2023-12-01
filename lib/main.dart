import 'package:flutter/material.dart';
import 'package:rexburgdancing/constant/routs.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/views/login_views.dart';
import 'package:rexburgdancing/views/register_views.dart';
import 'package:rexburgdancing/views/venue/new_venue.dart';
import 'package:rexburgdancing/views/venue_view.dart';
import 'package:rexburgdancing/views/vierfy_email_view.dart';

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
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        venueRoute: (context) => const DanceVenueView(),
        verfiyEmailRoute: (context) => const VerfiyEmailView(),
        newVenueRoute:(context) =>  const NewVenueView(),

      },
    ));
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().initialize(),
        builder: (context, snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
            final user = AuthService.firebase().currentuser;
            if (user != null){
              if (user.isEmailVerfied){
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



import 'package:flutter/material.dart';
import 'package:rexburgdancing/constant/routs.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/views/KingRoundUp/kings_comment.dart';
import 'package:rexburgdancing/views/Tavern/tavern_comment.dart';
import 'package:rexburgdancing/views/dance_list.dart';
import 'package:rexburgdancing/views/KingRoundUp/kings_view.dart';
import 'package:rexburgdancing/views/login_views.dart';
import 'package:rexburgdancing/views/register_views.dart';
import 'package:rexburgdancing/views/RootsAndBoots/roots_comment.dart';
import 'package:rexburgdancing/views/RootsAndBoots/roots_view.dart';
import 'package:rexburgdancing/views/Tavern/tavern_view.dart';
import 'package:rexburgdancing/views/venue/new_venue.dart';
import 'package:rexburgdancing/views/song_request_list.dart';
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
        songListRoute: (context) => const SongListView(),
        verfiyEmailRoute: (context) => const VerfiyEmailView(),
        newVenueRoute:(context) =>  const NewVenueView(),
        tavernRoute:(context) => const TavernView(),
        tavernCommentRoute:(context) => const TavernCommentView(),
        kingRoundUpRoute:(context) => const KingRoundUpPage(),
        kingsCommentRoute:(context) => const KingsCommentView(),
        danceListRoute:(context) => const DanceListView(),
        rootsAndBootsRoute:(context) => const RootsAndBootsView(),
        rootsCommentRoute:(context) => const RootsCommentView(),

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
                return const DanceListView();
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



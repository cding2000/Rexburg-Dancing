import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/services/crud/notes_service.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';

class DanceVenueView extends StatefulWidget {
  const DanceVenueView({super.key});


  @override
  State<DanceVenueView> createState() => _DanceVenueViewState();
}

class _DanceVenueViewState extends State<DanceVenueView> {

  late final NoteServices _noteService;
  String get userEmail => AuthService.firebase().currentuser!.email!;

  @override
  void initState() {
    _noteService = NoteServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dance Venue In Rexburg'),
      actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed(newVenueRoute);
        }, icon: const Icon(Icons.add)),

        PopupMenuButton<MenuAction>(onSelected: (value) async {
          switch (value)  {
            case MenuAction.logout:
              final shouldLogout = await showLogoutDialog(context);
              if (shouldLogout){
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
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
      body: 
      FutureBuilder(
        future: _noteService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:
              return StreamBuilder(stream: _noteService.allNotes,
              builder: (context, snapshot) {
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.hasData){
                      final allNotes =snapshot.data as List<DataBaseNote>;
                      return ListView.builder(
                        itemCount: allNotes.length,
                        itemBuilder: (context, index) {
                          final note = allNotes[index];
                          return ListTile(
                            title: Text(note.text,
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            ),
                            

                          );
                        },
                      );
                    }
                    else{
                      return const CircularProgressIndicator();
                    }

                  default:
                    return const CircularProgressIndicator();

                }
              },);
            default:
              return const CircularProgressIndicator();
          


          }
          
        },
      ),
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
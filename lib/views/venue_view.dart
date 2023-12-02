import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/services/crud/notes_service.dart';
import 'package:rexburgdancing/views/venue/notes_list_view.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';
import '../utilities/log_out_dialog.dart';

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
              final shouldLogout = await showLogOutDialog(context);
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
                      return NotesListView(notes: allNotes,
                       onDeleteNote: (note) async {
                       await _noteService.deleteNote(id: note.id);
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


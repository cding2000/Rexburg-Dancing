
import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/services/cloud/cloud_note.dart';
import 'package:rexburgdancing/services/cloud/firebase_cloud_storage.dart';
import 'package:rexburgdancing/views/venue/notes_list_view.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';
import '../utilities/log_out_dialog.dart';

class SongListView extends StatefulWidget {
  const SongListView({super.key});


  @override
  State<SongListView> createState() => _SongListViewState();
}

class _SongListViewState extends State<SongListView> {

  late final FirebaseCloudStorage _noteService;
  String get userId => AuthService.firebase().currentuser!.id;

  @override
  void initState() {
    _noteService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Song Request List'),
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
      StreamBuilder(stream: _noteService.allNotes(ownerUserId: userId),
              builder: (context, snapshot) {
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    if (snapshot.hasData){
                      final allNotes =snapshot.data as Iterable<CloudNote>;
                      return NotesListView(notes: allNotes,
                       onDeleteNote: (note) async {
                       await _noteService.deleteNote(documentId: note.documentId);
                       },
                       onTap: (note) {
                          Navigator.of(context).pushNamed(newVenueRoute, arguments: note,);
                       },
                       );
                    }
                    else{
                      return const CircularProgressIndicator();
                    }

                  default:
                    return const CircularProgressIndicator();

                }
              },
              ),
              );
  }
}


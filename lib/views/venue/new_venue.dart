import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/utilities/generic/get_argument.dart';
import 'package:rexburgdancing/services/cloud/cloud_note.dart';
import 'package:rexburgdancing/services/cloud/cloud_storage_exception.dart';
import 'package:rexburgdancing/services/cloud/firebase_cloud_storage.dart';



class NewVenueView extends StatefulWidget {
  const NewVenueView({super.key});

  @override
  State<NewVenueView> createState() => _NewVenueViewState();
}

class _NewVenueViewState extends State<NewVenueView> {

  CloudNote? _note;
  late final FirebaseCloudStorage _noteServices;

  late final TextEditingController _textController;

  @override void initState(){

    _noteServices = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListenner()async {
    final note = _note;
    if (note == null){
      return;
    }
    final text = _textController.text;
    await _noteServices.updateNote(documentId: note.documentId, text: text);
  }

  void _setupTextControllerListenner(){
    _textController.removeListener(_textControllerListenner);
    _textController.addListener(_textControllerListenner);

  }

  Future<CloudNote> createNewNote(BuildContext context) async{

    final widgetNote = context.getArgument<CloudNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final exisitingNote = _note;
    if (exisitingNote != null){
      return exisitingNote;
    }
    final currentuser = AuthService.firebase().currentuser!;
    final userId = currentuser.id;
    final newNote = await _noteServices.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }



  void _saveNoteIftextIsNotEmpty() async{
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty){
      await _noteServices.updateNote(documentId: note.documentId, text: text);
    } 
  }
    void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    if (_textController.text.isEmpty && note != null){
      _noteServices.deleteNote(documentId: note.documentId);
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTextIsEmpty();
    _saveNoteIftextIsNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Venue Page'),
      ),
      body: FutureBuilder(
        future: createNewNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              _setupTextControllerListenner();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Putting in your song request',
                ),
              );
            default:
              return const CircularProgressIndicator();
          }

        },
      ),
    );
  }
}
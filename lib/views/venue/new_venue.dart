import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';
import 'package:rexburgdancing/services/crud/notes_service.dart';

class NewVenueView extends StatefulWidget {
  const NewVenueView({super.key});

  @override
  State<NewVenueView> createState() => _NewVenueViewState();
}

class _NewVenueViewState extends State<NewVenueView> {

  DataBaseNote? _note;
  late final NoteServices _noteServices;

  late final TextEditingController _textController;

  @override void initState(){

    _noteServices = NoteServices();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListenner()async {
    final note = _note;
    if (note == null){
      return;
    }
    final text = _textController.text;
    await _noteServices.updateNote(note: note, text: text);
  }

  void _setupTextControllerListenner(){
    _textController.removeListener(_textControllerListenner);
    _textController.addListener(_textControllerListenner);

  }

  Future<DataBaseNote> createNewNote() async{
    final exisitingNote = _note;
    if (exisitingNote != null){
      return exisitingNote;
    }
    final currentuser = AuthService.firebase().currentuser!;
    final email = currentuser.email!;
    final owner = await _noteServices.getUser(email: email);
    return await _noteServices.createNote(owner: owner);
  }



  void _saveNoteIftextIsNotEmpty() async{
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty){
      await _noteServices.updateNote(note: note, text: text);
    } 
  }
    void _deleteNoteIfTextIsEmpty(){
    final note = _note;
    if (_textController.text.isEmpty && note != null){
      _noteServices.deleteNote(id: note.id);
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
        future: createNewNote(),
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
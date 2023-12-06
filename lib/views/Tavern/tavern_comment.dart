import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rexburgdancing/views/Tavern/tavern_post.dart';
import '../../constant/routs.dart';
import '../../enums/menu_action.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/log_out_dialog.dart';

class TavernCommentView extends StatefulWidget {
  const TavernCommentView({super.key});

  @override
  State<TavernCommentView> createState() => _TavernCommentViewState();
}

class _TavernCommentViewState extends State<TavernCommentView> {

    final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  void postMessage(){
    if(textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("tavern").add({
        'UserEmail': currentUser!.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 202, 202),
      appBar: AppBar(title: const Text('Tavern Comment Page'),
      actions: [

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
      
       Column(
          children: [
            Expanded(child: 
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("tavern").orderBy('TimeStamp', descending: false).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('Number of documents: ${snapshot.data!.docs.length}');
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      print('Post data: $post');
                      return TavernPost(message: post['Message'], 
                      user: post['UserEmail'],
                      postId: post.id,
                      likes: List<String>.from(post['Likes'] ?? []),);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error happened: ${snapshot.error}');
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                      children: [
              Expanded(child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                    hintText: 'Leave your comment here',
                    enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)
                    ),
                  ),
                  obscureText: false,
              )
              ),
              IconButton(onPressed: postMessage, icon: const Icon(Icons.arrow_circle_up)),
                      ],
                    ),
            )
          ],
        ),
    );
  }
}
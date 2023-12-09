import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rexburgdancing/views/KingRoundUp/kings_post.dart';
class KingsCommentView extends StatefulWidget {
  const KingsCommentView({super.key});

  @override
  State<KingsCommentView> createState() => _KingsCommentViewState();
}

class _KingsCommentViewState extends State<KingsCommentView> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  String? selectedPostId; // Track the selected post for editing

  void postMessage() {
    if (textController.text.isNotEmpty) {
      if (selectedPostId == null) {
        // Add new comment
        FirebaseFirestore.instance.collection("king").add({
          'UserEmail': currentUser!.email,
          'Message': textController.text,
          'TimeStamp': Timestamp.now(),
          'Likes': [],
        });
      } else {
        // Edit existing comment
        FirebaseFirestore.instance.collection("king").doc(selectedPostId).update({
          'Message': textController.text,
        });
        // Clear selectedPostId after editing
        setState(() {
          selectedPostId = null;
        });
      }

      // Clear the text field after posting or editing
      textController.clear();
    }
  }

  void editPost(String postId, String currentMessage) {
    setState(() {
      selectedPostId = postId;
      textController.text = currentMessage;
    });
  }

  void deletePost(String postId) {
    // Implement your delete logic
    FirebaseFirestore.instance.collection("king").doc(postId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 203, 202, 202),
      appBar: AppBar(
        title: const Text('Kings Round Up Comment Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection("king").orderBy('TimeStamp', descending: false).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print('Number of documents: ${snapshot.data!.docs.length}');
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data!.docs[index];
                      print('Post data: $post');
                      return KingsPost(
                        message: post['Message'],
                        user: post['UserEmail'],
                        postId: post.id,
                        likes: List<String>.from(post['Likes'] ?? []),
                        currentUser: currentUser?.email,
                        onEdit: () {
                          editPost(post.id, post['Message']);
                        },
                        onDelete: () {
                          deletePost(post.id);
                        },
                      );
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
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: 'Leave your comment here',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    obscureText: false,
                  ),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rexburgdancing/enums/like_button.dart';

class TavernPost extends StatefulWidget {

  final String message;
  final String user;
  final String postId;
  final List<String> likes;
  const TavernPost({super.key, required this.message, required this.user, required this.postId, required this.likes});

  @override
  State<TavernPost> createState() => _TavernPostState();
}

class _TavernPostState extends State<TavernPost> {

  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike(){
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = 
      FirebaseFirestore.instance.collection('tavern').doc(widget.postId);

      if (isLiked){
        postRef.update({
        "Likes": FieldValue.arrayUnion([currentUser.email])
        });
      }
      else{
        postRef.update({
        "Likes": FieldValue.arrayRemove([currentUser.email])
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius:BorderRadius.circular(8)),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Column(
            children: [
              LikeButton(isLiked: isLiked, onTap:toggleLike,),
              const SizedBox(height: 5,),
              Text(widget.likes.length.toString()),

            ],
          ),
          const SizedBox(width: 20,),

          Column(
            children: [
              Text(widget.user),
              Text(widget.message),
    
    
            ],
          )
    
        ],
      ),
    );
  }
}
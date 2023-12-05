import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import '../utilities/log_out_dialog.dart';


class KingRoundUpPage extends StatefulWidget {
  const KingRoundUpPage({super.key});


  @override
  State<KingRoundUpPage> createState() => _KingRoundUpPageState();
}

class _KingRoundUpPageState extends State<KingRoundUpPage> {
  
  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();
  List<String> comments = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get commentsCollection =>
      _firestore.collection('king');

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  Future<void> _loadComments() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await commentsCollection.get();

      setState(() {
        comments = snapshot.docs
            .map((doc) => (doc.data()['comment'] ?? '') as String)
            .toList();
      });
    } catch (e) {
      print('Error loading comments: $e');
    }
  }

  Future<void> _submitComment(String comment) async {
    try {
      await commentsCollection.add({'comment': comment});
      _loadComments();
    } catch (e) {
      print('Error submitting comment: $e');
    }
  }

  Future<void> _deleteComment(String comment) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await commentsCollection.where('comment', isEqualTo: comment).get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        await commentsCollection.doc(doc.id).delete();
      }

      _loadComments();
    } catch (e) {
      print('Error deleting comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Text('King Round Up'),
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
        SingleChildScrollView(
        child:
        Column(
        children:<Widget>[
          Card(
              elevation: 10,
              child: Column(
              children: <Widget>[
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/king1.png'),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/king2.png'),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/king3.png'),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/king4.png'),
                      ),
                      
                  
                    ),
                  )
                ],),
              ),

              const SizedBox(height: 10,),
              
              Text("King Round",style: GoogleFonts.pacifico(fontSize: 40),),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                launch('https://www.instagram.com/kingroundup_rexburg/');
              }, child: const Text('Official Page')),

              const SizedBox(height: 10,),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(venueRoute);
              }, icon: const Icon(Icons.my_library_music_outlined, size: 50,),),
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(venueRoute);
              }, icon: Image.asset('accests/images/facebook.png',height: 45,) ),
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(venueRoute);
              }, icon: Image.asset('accests/images/instagram.png',height: 45,) ),

              ]),

              const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('song quest'),
                Text('Facebook'),
                Text('Instagram'),
              ],
              ),

              const SizedBox(height: 10,),

              const Row(
                children:[
                SizedBox(width: 40),
                Text('Address:'),
                InkWell(
  onTap: _launchURL,
  child: Text(
    '210 Cleveland St, Idaho Falls, ID 83401',
    style: TextStyle(
      fontSize: 15,
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  ),
),]

              ),
              const SizedBox(height: 20,),
              
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              starRate(),
          ],
          
        ),

        const SizedBox(height: 20,),
                  const Text("Comments", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  // List of comments
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(comments[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteComment(comments[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  // Text field for new comment
                  TextField(
                    controller: textController,
                    obscureText: false,
                    decoration: const InputDecoration(
                  hintText: 'Leave your comment here',
                ),
                    // ... Existing code
                  ),
                  // Button to submit a comment
                  ElevatedButton(
        onPressed: () {
          setState(() {
            _submitComment(textController.text);
            textController.clear();
          });
        },
        child: const Text('Submit Comment'),
      ),

      


              
         ],
         
        ),
            ),
          
        ])
      ),

        );
    
  }


  starRate() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) => debugPrint(rating.toString()),
    );
  }

}


_launchURL() async {
  Uri _url = Uri.parse('https://www.google.com/maps/place/210+Cleveland+St,+Idaho+Falls,+ID+83401/data=!4m2!3m1!1s0x53545eac8bae1565:0xd4f26411d9c0b6a8?sa=X&ved=2ahUKEwjh0-OlhfeCAxVED0QIHSCOAREQ8gF6BAgQEAA');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}


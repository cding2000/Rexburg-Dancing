import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rexburgdancing/views/Tavern/tavern_comment.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/routs.dart';
import '../../enums/menu_action.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/log_out_dialog.dart';


class TavernView extends StatefulWidget {
  const TavernView({super.key});


  @override
  State<TavernView> createState() => _TavernViewState();
}

class _TavernViewState extends State<TavernView> {
  double averageRating = 0;
  int numberOfRatings = 0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadRatingData();
  }

  Future<void> _loadRatingData() async {
  try {
    User? user = _auth.currentUser;

    // Fetch the ratings data from Firestore
    QuerySnapshot querySnapshot = await _firestore.collection('tavern_ratings').get();
    int totalRatings = 0;
    double totalRating = 0;

    Map<String, double> latestRatings = {};

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

      // Check if the required fields exist in the document
      if (data != null && data['userId'] != null && data['rating'] != null) {
        // Check if the rating is from the current user
        if (user != null && data['userId'] == user.uid) {
          // Update the latest rating for the current user
          latestRatings[user.uid] = data['rating'];
        } else {
          // Update the latest rating for other users
          latestRatings[data['userId']] =
              latestRatings[data['userId']] == null || latestRatings[data['userId']]! < data['rating']
                  ? data['rating']
                  : latestRatings[data['userId']]!;
        }

        totalRatings++;
        totalRating += latestRatings[data['userId']]!;
      }
    });

    if (totalRatings > 0) {
      setState(() {
        numberOfRatings = totalRatings;
        averageRating = totalRating / totalRatings;
      });
    }
  } catch (e) {
    print('Error loading rating data: $e');
  }
}

  Future<void> _submitRating(double rating) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Store or update the latest rating for the current user in Firestore
        await _firestore.collection('tavern_ratings').doc(user.uid).set({
          'userId': user.uid,
          'rating': rating,
        });

        // Reload the rating data
        await _loadRatingData();
      }
    } catch (e) {
      print('Error submitting rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tavern'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            },
            itemBuilder: (context) {
              return const [PopupMenuItem<MenuAction>(value: MenuAction.logout, child: Text('Log out'))];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                            onTap: () {},
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('accests/images/tavern1.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('accests/images/tavern2.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('accests/images/tavern3.png'),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 350,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                              child: Image.asset('accests/images/tavern0.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("Tavern", style: GoogleFonts.pacifico(fontSize: 40)),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Wed/Fri: ", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                      Text("8:30-12:00 am ", style: TextStyle(fontSize: 17)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      launch('https://www.instagram.com/thetavernrexburg/');
                    },
                    child: const Text('Official Page'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(songListRoute);
                        },
                        icon: const Icon(Icons.my_library_music_outlined, size: 50),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(songListRoute);
                        },
                        icon: Image.asset('accests/images/facebook.png', height: 45),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(songListRoute);
                        },
                        icon: Image.asset('accests/images/instagram.png', height: 45),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('song quest'),
                      Text('Facebook'),
                      Text('Instagram'),
                    ],
                  ),
                  const SizedBox(height: 10),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Address:'),
                      InkWell(
                        onTap: _launchURL,
                        child: const Text(
                          '3878 Jake Way, Rexburg ID',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Column(
                    children: [
                      Text('Pricing Detail:', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                      Text('General Admission: \$5', style: TextStyle(fontSize: 18)),
                      Text('Student Discount: \$4', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      starRate(),
                      const SizedBox(height: 10),
                      Text(
                        'Average Rating: ${averageRating.toStringAsFixed(2)} (${numberOfRatings} ratings)',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TavernCommentView(),
                        ),
                      );
                    },
                    child: const Text('Leave your comments here.', style: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget starRate() {
    return RatingBar.builder(
      initialRating: averageRating,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        debugPrint(rating.toString());
        _submitRating(rating);
      },
    );
  }

  _launchURL() async {
    Uri _url = Uri.parse(
        'https://www.google.com/maps/place/3878+Jake+Wy,+Rexburg,+ID+83440/@43.7745918,-111.8419009,17z/data=!3m1!4b1!4m6!3m5!1s0x53540ccc0d6a6797:0x7f71fd1221e120a7!8m2!3d43.774588!4d-111.839326!16s%2Fg%2F11tgf4gft5?entry=ttu');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}

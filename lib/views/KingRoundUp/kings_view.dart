import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rexburgdancing/views/KingRoundUp/kings_comment.dart';

import '../../constant/routs.dart';
import '../../enums/menu_action.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/log_out_dialog.dart';

class KingRoundUpPage extends StatefulWidget {
  const KingRoundUpPage({Key? key});

  @override
  State<KingRoundUpPage> createState() => _KingRoundUpPageState();
}

class _KingRoundUpPageState extends State<KingRoundUpPage> {
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
      QuerySnapshot querySnapshot = await _firestore.collection('ratings').get();
      int totalRatings = 0;
      double totalRating = 0;

      Map<String, double> latestRatings = {};

      querySnapshot.docs.forEach((doc) {
        // Check if the rating is from the current user
        if (user != null && doc['userId'] == user.uid) {
          // Update the latest rating for the current user
          latestRatings[user.uid] = doc['rating'];
        } else {
          // Update the latest rating for other users
          latestRatings[doc['userId']] =
              latestRatings[doc['userId']] == null || latestRatings[doc['userId']]! < doc['rating']
                  ? doc['rating']
                  : latestRatings[doc['userId']]!;
        }

        totalRatings++;
        totalRating += latestRatings[doc['userId']]!;
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
        await _firestore.collection('ratings').doc(user.uid).set({
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
        title: const Text('King Round Up'),
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
                              child: Image.asset('accests/images/king1.png'),
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
                              child: Image.asset('accests/images/king2.png'),
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
                              child: Image.asset('accests/images/king3.png'),
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
                              child: Image.asset('accests/images/king4.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("King Round Up", style: GoogleFonts.pacifico(fontSize: 40)),
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
                      launch('https://www.instagram.com/kingroundup_rexburg/');
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
                          '309 Profit St. Rexburg ID 83440',
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
                          builder: (context) => const KingsCommentView(),
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
        'https://www.google.com/maps/place/309+Profit+St,+Rexburg,+ID+83440/@43.8500896,-111.7747611,17z/data=!4m15!1m8!3m7!1s0x53540a17792a27b7:0xed6bcbda5fbc4525!2s309+Profit+St,+Rexburg,+ID+83440!3b1!8m2!3d43.8500896!4d-111.7747611!16s%2Fg%2F11vkrwl2ht!3m5!1s0x53540a17792a27b7:0xed6bcbda5fbc4525!8m2!3d43.8500896!4d-111.7747611!16s%2Fg%2F11vkrwl2ht?entry=ttu');
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}

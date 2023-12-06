import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rexburgdancing/enums/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  String? username;
  String? bio;
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> editField(String field) async {
    String? newValue;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextFormField(
            initialValue: field == 'username' ? username : bio,
            onChanged: (value) {
              newValue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                setState(() {
                  if (field == 'username') {
                    username = newValue;
                  } else if (field == 'bio') {
                    bio = newValue;
                  }
                });

                // Update the field in Firestore with the new value
                final currentUser = this.currentUser;
                if (currentUser != null) {
                  await firestoreInstance
                      .collection('users')
                      .doc(currentUser.uid)
                      .update({
                    field: newValue,
                  });
                }

                // Close the dialog
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 197, 197),
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),
          const Icon(Icons.person, size: 72),
          const SizedBox(height: 10),
          Text(currentUser?.email ?? "No email available", textAlign: TextAlign.center),
          const SizedBox(height: 50),
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text('My Details'),
          ),
          MytextBox(
            text: username ?? '',
            sectionName: 'User Name',
            onPressed: () {
              editField('username');
            },
          ),
          MytextBox(
            text: bio ?? '',
            sectionName: 'Bio',
            onPressed: () {
              editField('bio');
            },
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text('My Posts'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _username;
  String? _bio;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('users').doc(user.uid).get();

        if (documentSnapshot.exists) {
          setState(() {
            _username = documentSnapshot['username'];
            _bio = documentSnapshot['bio'];
          });
        }
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> _saveUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'username': _username,
          'bio': _bio,
        });
      }
    } catch (e) {
      print('Error saving user data: $e');
    }
  }

  Future<void> _editField(String field, String initialValue) async {
    String? newValue = initialValue;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextFormField(
            initialValue: initialValue,
            onChanged: (value) {
              newValue = value;
            },
            decoration: InputDecoration(
              labelText: 'Enter new $field',
            ),
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
                    _username = newValue;
                  } else if (field == 'bio') {
                    _bio = newValue;
                  }
                });

                await _saveUserData();

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
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 72,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(
                'Username: ${_username ?? 'Not set'}',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _editField('username', _username ?? '');
              },
            ),
            const Divider(),
            ListTile(
              title: Text(
                'Bio: ${_bio ?? 'Not set'}',
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                _editField('bio', _bio ?? '');
              },
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfilePage(),
  ));
}

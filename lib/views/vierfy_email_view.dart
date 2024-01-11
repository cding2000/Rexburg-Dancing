import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';

import '../constant/routs.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              registerRoute,
              (route) => false,
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("accests/images/email_verfy.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            const Icon(
              Icons.email,
              color: Colors.white,
              size: 60,
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Please verify your email",
                style: TextStyle(
                  color: Color.fromARGB(255, 175, 159, 11),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We have sent a verification email to your registered email address.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 175, 159, 11),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () async {
                await AuthService.firebase().sendEmailVerification();
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 12, 12, 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              icon: Icon(Icons.send, size: 30, color: Color.fromARGB(255, 175, 159, 11)),
              label: const Text(
                'Resend Verification Email', 
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 175, 159, 11)),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton.icon(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Color.fromARGB(255, 175, 159, 11)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
              icon: Icon(Icons.refresh, size: 30, color: Color.fromARGB(255, 175, 159, 11)),
              label: const Text(
                'Restart',
                style: TextStyle(
                  color: Color.fromARGB(255, 175, 159, 11),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

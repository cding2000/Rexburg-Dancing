import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  // Add a GlobalKey for the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller for the email input field
  final TextEditingController _emailController = TextEditingController();

  // Function to handle the password reset logic
  void _resetPassword() {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      // Add your password reset logic here
      // For example, you can use _emailController.text to get the entered email
      // and send a reset email or perform the necessary actions.
      // Replace the print statement with your actual logic.
      print('Resetting password for ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password Page'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Reset your password here!',
            style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 175, 159, 11)),
          ),
          Form(
            key: _formKey, // Assign the key to the form
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController, // Connect the controller to the text field
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Color.fromRGBO(175, 159, 11, 1)),
                  decoration: InputDecoration(
                    hintText: 'Enter your email here',
                    hintStyle: TextStyle(color: Color.fromRGBO(175, 159, 11, 1)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // You can add more email validation if needed
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: Text('Reset Password'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';

import '../constant/routs.dart';

class VerfiyEmailView extends StatefulWidget {
  const VerfiyEmailView({super.key});

  @override
  State<VerfiyEmailView> createState() => _VerfiyEmailViewState();
}

class _VerfiyEmailViewState extends State<VerfiyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verfied Email'),
      leading: BackButton(
        onPressed: () {Navigator.of(context).pushNamedAndRemoveUntil(registerRoute
                  , (route) => false,
                  );}
      ),
      ),
      body: Column(children: [
        const Text("We've send you an email verfication. Please open it to verfiy yourself."),
        const Text('Not recevied email yet? Press the button to resend it.'),
        TextButton(onPressed: () async{
          await AuthService.firebase().sendEmailVerification();

        }, child: const Text('Send email verfication'),
        ),
        TextButton(onPressed: () async{
          await AuthService.firebase().logOut();
          Navigator.of(context).pushNamedAndRemoveUntil(registerRoute
                  , (route) => false,
                  );
        }, child: const Text('Restart'),
        ),
      ],
      ),
    );
  }

}
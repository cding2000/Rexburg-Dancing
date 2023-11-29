import 'package:flutter/material.dart';
import 'package:rexburgdancing/services/auth/auth_service.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';

class DanceVenueView extends StatefulWidget {
  const DanceVenueView({super.key});

  @override
  State<DanceVenueView> createState() => _DanceVenueViewState();
}

class _DanceVenueViewState extends State<DanceVenueView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dance Venue In Rexburg'),
      actions: [
        PopupMenuButton<MenuAction>(onSelected: (value) async {
          switch (value)  {
            case MenuAction.logout:
              final shouldLogout = await showLogoutDialog(context);
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
      body: const Text('Hello'),
      );
  }
}

Future<bool> showLogoutDialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder: (context){
      return AlertDialog(
      title: const Text("Sign out"),
      content: const Text('Are you sure you want yo log out?'),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop(false);
        }, 
        child: const Text('Cancel')
        ),
        TextButton(onPressed: (){
          Navigator.of(context).pop(true);
        }, 
        child: const Text('Logout')
        ),
      ],
      );
  },
  ).then((value) => value ?? false);

}
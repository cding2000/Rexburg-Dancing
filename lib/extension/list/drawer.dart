import 'package:flutter/material.dart';
import 'package:rexburgdancing/extension/list/list_title.dart';

class Mydrawer extends StatelessWidget {
  final void Function()? onProfileTap;
  final void Function()? onSignOut;
  const Mydrawer({super.key, required this.onProfileTap, required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
          const DrawerHeader(child: Icon(Icons.person, color: Colors.white, size: 80,), ),
          MyListTitle(icon: Icons.home, text: 'H O M E', onTap: () {
            
          },),
          MyListTitle(icon: Icons.person, text: 'P R O F I L E', onTap:onProfileTap, ),

            ],
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: MyListTitle(icon: Icons.logout, text: 'L O G O U T', onTap: onSignOut,),
          ),


        ],
      ),
    );
  }
}
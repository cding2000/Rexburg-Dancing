import 'package:flutter/material.dart';
import 'package:rexburgdancing/views/kings_view.dart';
import 'package:rexburgdancing/views/tavern_view.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import '../utilities/log_out_dialog.dart';

class DanceListView extends StatefulWidget {
  const DanceListView({Key? key}) : super(key: key);

  @override
  State<DanceListView> createState() => _DanceListViewState();
}

class _DanceListViewState extends State<DanceListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tavern'),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TavernView(),
                  ),
                );
                print('Second Card Clicked!');
                // You can navigate to another screen or perform any action here.
              },
              splashColor: Colors.blue,
              child: Card(
                elevation: 10,
                child: Image.asset("accests/images/tavern1.png"), // Make sure to adjust the path based on your project structure
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KingRoundUpPage(),
                  ),
                );
                print('Second Card Clicked!');
                // You can navigate to another screen or perform any action here.
              },
              splashColor: Colors.blue,
              child: Card(
                elevation: 10,
                child: Image.asset("accests/images/king2.png"), // Make sure to adjust the path based on your project structure
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

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
      appBar: AppBar(title: const Text('Dance Venue'),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TavernView(),
                  ),
                );
                print('Tavern Card Clicked!');
              },
              splashColor: Colors.blue,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        "accests/images/tavern1.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tavern Venue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KingRoundUpPage(),
                  ),
                );
                print('King Round Up Card Clicked!');
              },
              splashColor: Colors.blue,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.asset(
                        "accests/images/king2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'King Round Up Venue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
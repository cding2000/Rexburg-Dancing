import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import '../utilities/log_out_dialog.dart';


class VenueDetailPage extends StatefulWidget {
  const VenueDetailPage({super.key});

  @override
  State<VenueDetailPage> createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
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
      body: 
        SingleChildScrollView(
        child: 
        Column(
        children:<Widget>[
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
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/tavern1.png'),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/tavern2.png'),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/tavern3.png'),
                      ),
                  
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell( 
                      onTap: (){},
                      child: Container(
                        width: 350,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: Image.asset('accests/images/tavern0.png'),
                      ),
                      
                  
                    ),
                  )
                ],),
              ),
              Text("Tavern",style: GoogleFonts.pacifico(fontSize: 40),),
              ElevatedButton(onPressed: (){
                launch('https://www.instagram.com/thetavernidahofalls/');
              }, child: const Text('Official Page')),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(venueRoute);
              }, icon: const Icon(Icons.my_library_music_outlined, size: 50,),),
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(venueRoute);
              }, icon: Image.asset('accests/images/facebook.png',height: 45,) ),
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(venueRoute);
              }, icon: Image.asset('accests/images/instagram.png',height: 45,) ),

              ]),

              const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('song quest'),
                Text('Facebook'),
                Text('Instagram'),
              ],
              ),
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              starRate(),
          ],
          
        ),
              
         ],
        ),
            ),
          
        ])
      )
        );
    
  }


  starRate() {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 5),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) => debugPrint(rating.toString()),
    );
  }

}
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rexburgdancing/views/roots_comment.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/routs.dart';
import '../enums/menu_action.dart';
import '../services/auth/auth_service.dart';
import '../utilities/log_out_dialog.dart';


class RootsAndBootsView extends StatefulWidget {
  const RootsAndBootsView({super.key});


  @override
  State<RootsAndBootsView> createState() => _RootsAndBootsViewState();
}

class _RootsAndBootsViewState extends State<RootsAndBootsView> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Text('Roots and Boots'),
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
                        child: Image.asset('accests/images/king1.png'),
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
                        child: Image.asset('accests/images/king2.png'),
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
                        child: Image.asset('accests/images/king3.png'),
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
                        child: Image.asset('accests/images/king4.png'),
                      ),
                      
                  
                    ),
                  )
                ],),
              ),

              const SizedBox(height: 10,),
              
              Text("Roots and Boots",style: GoogleFonts.pacifico(fontSize: 40),),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                launch('https://www.instagram.com/kingroundup_rexburg/');
              }, child: const Text('Official Page')),

              const SizedBox(height: 10,),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(songListRoute);
              }, icon: const Icon(Icons.my_library_music_outlined, size: 50,),),
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(songListRoute);
              }, icon: Image.asset('accests/images/facebook.png',height: 45,) ),
              IconButton(onPressed: (){
              Navigator.of(context).pushNamed(songListRoute);
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

              const SizedBox(height: 10,),

              const Row(
                children:[
                SizedBox(width: 40),
                Text('Address:'),
                InkWell(
  onTap: _launchURL,
  child: Text(
    '309 Profit St. Rexburg ID 83440',
    style: TextStyle(
      fontSize: 15,
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  ),
),]

              ),
              const SizedBox(height: 20,),
              
              Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              starRate(),
          ],
          
        
        ),

        TextButton(onPressed: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RootsCommentView(),
                  ),
                );
    
                }, 
                child: const Text('Leave your comments here.',style: TextStyle(color: Colors.amber),),
                )


         ],
        

        ),
            ),
          
        ])
      ),

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


_launchURL() async {
  Uri _url = Uri.parse('https://www.google.com/maps/place/210+Cleveland+St,+Idaho+Falls,+ID+83401/data=!4m2!3m1!1s0x53545eac8bae1565:0xd4f26411d9c0b6a8?sa=X&ved=2ahUKEwjh0-OlhfeCAxVED0QIHSCOAREQ8gF6BAgQEAA');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}


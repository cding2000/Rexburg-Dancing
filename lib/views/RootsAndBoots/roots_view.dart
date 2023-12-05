import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rexburgdancing/views/RootsAndBoots/roots_comment.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/routs.dart';
import '../../enums/menu_action.dart';
import '../../services/auth/auth_service.dart';
import '../../utilities/log_out_dialog.dart';


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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Wed/Fri/Sat: ", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17)),
                  Text("7:30-12:00 am ", style: TextStyle(fontSize: 17),)
                ],
              ),
              

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
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                Text('Address: '),
                InkWell(
  onTap: _launchURL,
  child: Text(
    '433 Airport Rd, Rexburg ID',
    style: TextStyle(
      fontSize: 15,
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  ),
),]

              ),
              const SizedBox(height: 20,),

              const Column(
                children: [
                  Text('Pricing Detail:', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                  Text('General Admission: \$5', style: TextStyle(fontSize: 18)),
                  Text('Student Discount: \$4', style: TextStyle(fontSize: 18)),
                ],
              ),


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
                child: const Text('Leave your comments here.',style: TextStyle(fontSize: 25),),
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
  Uri _url = Uri.parse('https://www.google.com/maps/place/433+Airport+Rd,+Rexburg,+ID+83440/@43.8354794,-111.8110441,17z/data=!3m1!4b1!4m6!3m5!1s0x53540bc86d6717ab:0xd54adccbb72e0270!8m2!3d43.8354756!4d-111.8084692!16s%2Fg%2F11c4dlr0tf?entry=ttu');
  if (await launchUrl(_url)) {
    await launchUrl(_url);
  } else {
    throw 'Could not launch $_url';
  }
}


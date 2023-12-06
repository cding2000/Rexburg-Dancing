import 'package:flutter/material.dart';

class MytextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  void Function()? onPressed;
  MytextBox({super.key, required this.text, required this.sectionName, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionName),
              IconButton(onPressed: onPressed, icon: Icon(Icons.settings)),
            ],
          ),


          Text(text),
        ],
      ),
    );
  }
}
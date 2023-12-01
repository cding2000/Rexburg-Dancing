import 'package:flutter/material.dart';

class NewVenueView extends StatefulWidget {
  const NewVenueView({super.key});

  @override
  State<NewVenueView> createState() => _NewVenueViewState();
}

class _NewVenueViewState extends State<NewVenueView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Venue Page'),
      ),
      body: const Text('Add the new venue here'),
    );
  }
}
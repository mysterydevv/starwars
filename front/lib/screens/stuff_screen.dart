import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/stuff/stuff_card.dart';
import 'package:flutter_movie/components/stuff/stuff_form.dart';
import 'package:flutter_movie/models/stuff.dart';
import 'package:flutter_movie/services/stuff_service.dart';

class StuffScreen extends StatelessWidget {
  const StuffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: StuffScreenHome(),
    );
  }
}

class StuffScreenHome extends StatefulWidget {
  const StuffScreenHome({super.key});

  @override
  StuffScreenHomeState createState() => StuffScreenHomeState();
}

class StuffScreenHomeState extends State<StuffScreenHome> {
  late Future<List<Stuff>> _stuff;
  StuffService stuffService = StuffService();

  @override
  void initState() {
    super.initState();
    _stuff = stuffService.getAllMembersOfStuff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OwnAppBar(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Stuff Members',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Stuff>>(
              future: _stuff,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Column(
                    children: snapshot.data!
                        .map((stuff) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: StuffCard(stuff: stuff),
                    ))
                        .toList(),
                  );
                } else {
                  return const Text('No stuff members found');
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (context) => const StuffForm());
              },
              child: const Text('Add new stuff member'),
            ),
          ],
        ),
      ),
    );
  }
}

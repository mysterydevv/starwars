import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/circular_avatar.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/stuff/stuff_update_form.dart';
import 'package:flutter_movie/models/stuff.dart';
import 'package:flutter_movie/screens/stuff_screen.dart';
import 'package:flutter_movie/services/file_service.dart';
import 'package:flutter_movie/services/stuff_service.dart';

class StuffDetailsScreen extends StatelessWidget {
  final Stuff stuff;
  const StuffDetailsScreen({super.key, required this.stuff});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StuffDetailsScreenHome(stuff: stuff),
    );
  }
}

class StuffDetailsScreenHome extends StatefulWidget {
  final Stuff stuff;
  const StuffDetailsScreenHome({super.key, required this.stuff});

  @override
  State<StatefulWidget> createState() {
    return StuffDetailHomeState();
  }
}

class StuffDetailHomeState extends State<StuffDetailsScreenHome> {
  late Future<String> image;
  FileService fileService = FileService();
  StuffService stuffService = StuffService();

  @override
  void initState() {
    super.initState();
    image = fileService.read(widget.stuff.image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const OwnAppBar(),
            const SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const StuffScreen()));
                  },
                ),
                const SizedBox(width: 90),
                const Text(
                  'Stuff Details Screen',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) => UpdateStuffDialog(stuff: widget.stuff));
                  },
                  icon: const Icon(Icons.edit),
                ),
                const SizedBox(width: 5),
                IconButton(
                  onPressed: () async {
                    await stuffService.deleteMemberOfStuff(widget.stuff.id!);
                    // ignore: use_build_context_synchronously
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const StuffScreen()));
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
            const SizedBox(height: 20),
            OwnCircularAvatar(image: image),
            const SizedBox(height: 20),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Full Name',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          widget.stuff.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Activity',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          widget.stuff.activity,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Bio',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                          widget.stuff.biography!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

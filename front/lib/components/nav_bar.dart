import 'package:flutter/material.dart';
import 'package:flutter_movie/main.dart';
import 'package:flutter_movie/screens/cinema_screen.dart';
import 'package:flutter_movie/screens/stuff_screen.dart';
import 'package:flutter_movie/screens/news.dart';
import 'package:flutter_movie/screens/cast_screen.dart';
import 'package:flutter_movie/screens/profile_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: const Color.fromRGBO(0, 0, 0, 1.0),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'lib/images/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      '',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded, color: Colors.black,),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart_rounded, color: Colors.black),
            title: const Text('Stuff'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const StuffScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.people_alt_rounded, color: Colors.black),
            title: const Text('Cast'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ActorScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded, color: Colors.black),
            title: const Text('News'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const NewsScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_city_rounded, color: Colors.black),
            title: const Text('Cinemas'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CinemaScreen()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person_2_rounded, color: Colors.black,
            ),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
          )
        ],
      ),
    );
  }
}

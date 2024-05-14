import 'package:flutter/material.dart';
import 'package:flutter_movie/components/app_bar.dart';
import 'package:flutter_movie/components/login_form.dart';
import 'package:flutter_movie/components/nav_bar.dart';
import 'package:flutter_movie/components/register_form.dart';
import 'package:flutter_movie/components/user_account.dart';
import 'package:flutter_movie/utils/token_storage.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfileScreenHome(),
    );
  }
}

class ProfileScreenHome extends StatefulWidget {
  const ProfileScreenHome({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenHomeState();
  }
}

class ProfileScreenHomeState extends State<ProfileScreenHome> {
  bool showLoginForm = true;
  TokenStorage tokenStorage = TokenStorage();
  

  void toggleForm() {
    setState(() {
      showLoginForm = !showLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OwnAppBar(),
            FutureBuilder<bool>(
              future: tokenStorage.hasToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  bool hasToken = snapshot.data ?? false;
                  return hasToken ? const UserAccountHome() : (showLoginForm
                          ? LoginForm(onRegister: toggleForm)
                          : RegisterForm(onLogin: toggleForm));
                }
              },
            ),
        
          ],
        ),
      ),
    );
  }
}

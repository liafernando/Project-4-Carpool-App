import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';
import '../mainScreens/about_screen.dart';
import '../mainScreens/profile_screen.dart';
import '../splashScreen/splash_screen.dart';

class MyDrawer extends StatefulWidget {
  String? name;
  String? email;

  MyDrawer({this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Drawer header
          Container(
            height: 165,
            color: Colors.grey,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.email ?? '',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12.0),

          // Drawer body
          GestureDetector(
            onTap: () {
            },
            child: ListTile(
              leading: const Icon(Icons.history, color: Colors.white54),
              title: const Text(
                "History",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => ProfileScreen()));
            },
            child: ListTile(
              leading: const Icon(Icons.person, color: Colors.white54),
              title: const Text(
                "Visit Profile",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => AboutScreen()));
              },
            child: ListTile(
              leading: const Icon(Icons.info, color: Colors.white54),
              title: const Text(
                "About",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              fAuth.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
            },
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.white54),
              title: const Text(
                "Sign Out",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

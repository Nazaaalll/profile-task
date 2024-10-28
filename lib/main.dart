import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:profile_app/services/profile%20.dart';

void main() {
  runApp(const MyProfile());
}

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Profile',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  get userController => null;

  get username => null;

  get bio => null;

  Future<void> _fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userprofile = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userprofile.exists) {
        setState(() {
          var username = userprofile['username'] ?? "Unknown User";
          var bio = userprofile['bio'] ?? "No bio available";
        });
      }
    }
  }

  void _showProfileUpdateDialog() {
    final TextEditingController usernameController =
        TextEditingController(text: username);
    final TextEditingController bioController =
        TextEditingController(text: bio);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Update Profile"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            ProfileUpdateButton(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Username: $username",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text("Bio: $bio",
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
              SizedBox(
                height: 40,
              ),
              SingleChildScrollView(
                child: TextButton(
                  onPressed: () {},
                  child: const Column(
                    children: [
                      Icon(Icons.feed),
                      Text('Feed'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.event),
                    const Text('Events'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.camera),
                    const Text('Post'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.notifications),
                    const Text('Notification'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
                child: Column(
                  children: [
                    Icon(Icons.person),
                    const Text('Account'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Column(
                  children: [
                    Icon(Icons.exit_to_app),
                    const Text('Logout'),
                  ],
                ),
              ),
              const SingleChildScrollView(),
            ],
          ),
        ),
      ),
    );
  }
}

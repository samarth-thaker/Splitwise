import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

void editProfile(BuildContext context) {
  Navigator.pushNamed(context, 'editProfile');
}

class _UserProfileState extends State<UserProfile> {
  final Color primaryColor = const Color.fromARGB(249, 0, 114, 188);
  final Color accentColor = const Color.fromARGB(249, 250, 200, 20);

  Widget customTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: accentColor),
      ),
      leading: Icon(icon, size: 30, color: accentColor),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      tileColor: primaryColor,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        AssetImage("assets/profile_placeholder.jpeg"),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Samarth Thaker',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.call, size: 18),
                      SizedBox(width: 5),
                      Text('9892813731', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            customTile("Edit Profile", Icons.edit, ()=>editProfile ),
            const SizedBox(height: 10),
            customTile("Notification Settings", Icons.notifications, () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Notification Settings Clicked")));
            }),
            const SizedBox(height: 10),
            customTile("Change Password", Icons.lock, () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Change Password Clicked")));
            }),
            const SizedBox(height: 10),
            customTile("Logout", Icons.exit_to_app, () {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Logged Out")));
            }),
          ],
        ),
      ),
    );
  }
}

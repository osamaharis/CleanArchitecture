import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Features/auth/Logout/Presentation/LogoutButton/LogoutButton.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Profile Page!"),
          LogoutButton(),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dark_cinemax/core/pages/auth/services/auth_service.dart';
import 'package:dark_cinemax/core/pages/profile/view/edit_profile_page.dart';
import 'package:dark_cinemax/core/pages/profile/view/grid_view.dart';
import 'package:dark_cinemax/core/pages/settings/setting.dart' show SettingPage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = AuthService().getCurrentUser();
  String name = '';
  String? imageBase64;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        name = data['name'] ?? user!.displayName ?? 'Anonymous User';
        imageBase64 = data['image'];
      });
    } else {
      // If no document exists, fallback to Firebase Auth
      setState(() {
        name = user!.displayName ?? 'Anonymous User';
        imageBase64 = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider profileImage;
    if (imageBase64 != null) {
      profileImage = MemoryImage(base64Decode(imageBase64!));
    } else if (user?.photoURL != null) {
      profileImage = NetworkImage(user!.photoURL!);
    } else {
      profileImage = const AssetImage('assets/default-profile.png');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
            },
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Card
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 16,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    // Profile Picture
                    CircleAvatar(radius: 60, backgroundImage: profileImage),
                    const SizedBox(height: 16),
                    // User Name
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // User Email
                    Text(
                      user?.email ?? "No Email",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 16),
                    // Edit Profile Button
                    ElevatedButton.icon(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                        // Reload profile after edit
                        _loadUserProfile();
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit Profile"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(120),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SavedMoviesGrid(),
          ],
        ),
      ),
    );
  }
}

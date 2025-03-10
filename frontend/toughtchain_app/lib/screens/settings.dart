import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toughtchain_app/widgets/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsEnabled = true;
  bool darkMode = false;
  bool privacyMode = false;

  // Logout-Funktion
  Future<void> signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Optional: Navigiere zur LoginPage, falls diese Route in deinem Navigator definiert ist.
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      // Fehlerbehandlung: Zeige ggf. eine Fehlermeldung an.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fehler beim Logout')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.black,
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: ColorPalette.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            color: ColorPalette.white,
            onPressed: () {
              // Optional: Weitere Navigation oder Overlay für zusätzliche Settings
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profil-Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorPalette.coolGray.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Profilbild (Placeholder oder geladenes Bild)
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: ColorPalette.emerald,
                    backgroundImage:
                        AssetImage('lib/assets/img/profile_placeholder.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'John Doe',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'johndoe@example.com',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: ColorPalette.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Statistiken (z.B. Projekte, Likes, Follower)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem('Projects', '12'),
                      _buildStatItem('Likes', '340'),
                      _buildStatItem('Followers', '1.2K'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Settings Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorPalette.coolGray.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSettingsTile(
                    icon: Icons.notifications,
                    title: 'Enable Notifications',
                    value: notificationsEnabled,
                    onChanged: (bool newValue) {
                      setState(() {
                        notificationsEnabled = newValue;
                      });
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.lock,
                    title: 'Privacy Mode',
                    value: privacyMode,
                    onChanged: (bool newValue) {
                      setState(() {
                        privacyMode = newValue;
                      });
                    },
                  ),
                  _buildSettingsTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    value: darkMode,
                    onChanged: (bool newValue) {
                      setState(() {
                        darkMode = newValue;
                      });
                    },
                  ),
                  const Divider(color: ColorPalette.coolGray),
                  // Weitere Optionen: About
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.info_outline,
                        color: ColorPalette.emerald),
                    title: const Text(
                      'About ThoughtChain',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: ColorPalette.white,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: ColorPalette.white, size: 16),
                    onTap: () {
                      // Navigation zur About-Seite oder Info-Dialog
                    },
                  ),
                  // Logout-Option mit implementierter Sign-Out-Funktion
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.logout, color: ColorPalette.emerald),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: ColorPalette.white,
                      ),
                    ),
                    onTap: () {
                      signUserOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hilfsfunktion für Statistiken
  Widget _buildStatItem(String label, String count) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorPalette.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 14,
            color: ColorPalette.white.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  // Hilfsfunktion für Settings ListTile mit Toggle
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      activeColor: ColorPalette.emerald,
      inactiveThumbColor: ColorPalette.white,
      inactiveTrackColor: ColorPalette.coolGray,
      contentPadding: EdgeInsets.zero,
      secondary: Icon(icon, color: ColorPalette.emerald),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: ColorPalette.white,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}

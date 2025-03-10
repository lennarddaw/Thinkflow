import 'package:flutter/material.dart';
import 'package:toughtchain_app/screens/settings.dart';
import 'package:toughtchain_app/widgets/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Beispiel-Daten: In einer echten App werden diese dynamisch geladen.
  final List<Map<String, String>> trendingIdeas = const [
    {"title": "Idea One", "description": "Short description..."},
    {"title": "Idea Two", "description": "Short description..."},
    {"title": "Idea Three", "description": "Short description..."},
    {"title": "Idea Four", "description": "Short description..."},
    {"title": "Idea Five", "description": "Short description..."},
  ];

  final List<Map<String, String>> latestIdeas = const [
    {"title": "New Idea 1", "description": "A brief description of this idea."},
    {"title": "New Idea 2", "description": "A brief description of this idea."},
    {"title": "New Idea 3", "description": "A brief description of this idea."},
    {"title": "New Idea 4", "description": "A brief description of this idea."},
    {"title": "New Idea 5", "description": "A brief description of this idea."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.black,
      appBar: AppBar(
  backgroundColor: ColorPalette.black,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(
        'lib/assets/img/netscanicon_white.png',
        height: 45,
        width: 45,
        fit: BoxFit.contain,
      ),

      Row(
        children: [
          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(Icons.wallet),
            color: ColorPalette.white,
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            child: const CircleAvatar(
              backgroundColor: ColorPalette.emerald,
            ),
          ),
        ],
      ),
    ],
  ),
),


      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Suchleiste
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: ColorPalette.coolGray.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: ColorPalette.white),
                  SizedBox(width: 8),
                  Text(
                    'Search ideas...',
                    style: TextStyle(
                      color: ColorPalette.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Trending Ideas Section
            const Text(
              'Latest projects',
              style: TextStyle(
                color: ColorPalette.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 170,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: trendingIdeas.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final idea = trendingIdeas[index];
                  return Container(
                    width: 170,
                    decoration: BoxDecoration(
                      color: ColorPalette.coolGray,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          idea['title']!,
                          style: const TextStyle(
                            color: ColorPalette.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Text(
                            idea['description']!,
                            style: const TextStyle(
                              color: ColorPalette.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            // Latest Ideas Section
            const Text(
              'Latest Ideas',
              style: TextStyle(
                color: ColorPalette.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: latestIdeas.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final idea = latestIdeas[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorPalette.coolGray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        idea['title']!,
                        style: const TextStyle(
                          color: ColorPalette.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        idea['description']!,
                        style: const TextStyle(
                          color: ColorPalette.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      // Floating Action Button zum Hinzufügen einer neuen Idee
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.emerald,
        onPressed: () {
          // Navigation zur Seite zum Erstellen einer neuen Idee
        },
        child: const Icon(Icons.add, color: ColorPalette.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorPalette.black,
        selectedItemColor: ColorPalette.emerald,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

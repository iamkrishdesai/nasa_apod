import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  AssetImage('assets/profile.jpg'), // Add your profile image
            ),
            SizedBox(height: 16),
            Text(
              'Cosmic Explorer 🚀',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Hi, I'm Krish — a Flutter developer who loves building beautiful apps and exploring the cosmos of code and creativity.",
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 24),
            _buildSectionTitle('What I Do 🌟'),
            Text(
              '⚙️ Flutter Developer | 📱 UI/UX Enthusiast | 🎨 Design Explorer | 🚀 Always Curious',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            _buildSectionTitle('Fun Facts 🤩'),
            Text(
              "🔥 Coffee fuels my code 🎵 Jazz melodies in my head while designing.📚 Devouring books on design, games, and tech.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            _buildSectionTitle("Let's Connect 🔗"),
            _buildSocialLinks(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurpleAccent,
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Icon(Icons.linked_camera),
          onPressed: () =>
              print('Open LinkedIn'), // Replace with URL launch logic
        ),
        IconButton(
          icon: Icon(Icons.code),
          onPressed: () =>
              print('Open GitHub'), // Replace with URL launch logic
        ),
        IconButton(
          icon: Icon(Icons.alternate_email),
          onPressed: () =>
              print('Open Twitter'), // Replace with URL launch logic
        ),
      ],
    );
  }
}

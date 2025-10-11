import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20),
          shrinkWrap: true,
          children: [
            ProfileCard(
              name: "Gian Adnan Sumaryo",
              email: "gianadnansumaryo@gmail.com",
              imagePath: "lib/assets/images/gian.png",
            ),
            const SizedBox(height: 16),
            ProfileCard(
              name: "Arza Armandhito",
              email: "arzaarmandhito@gmail.com",
              imagePath: "lib/assets/images/arja.png",
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String imagePath;

  const ProfileCard({
    Key? key,
    required this.name,
    required this.email,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(radius: 35, backgroundImage: AssetImage(imagePath)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

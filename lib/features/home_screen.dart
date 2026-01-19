import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tableau de bord", 
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
          ),
          const SizedBox(height: 20),
          
          // Grille de raccourcis
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildHomeCard("Planning", Icons.calendar_today, Colors.blue),
              _buildHomeCard("Messages", Icons.message, Colors.orange),
              _buildHomeCard("Absences", Icons.event_busy, Colors.green),
              _buildHomeCard("Documents", Icons.description, Colors.purple),
            ],
          ),
          const SizedBox(height: 20),
          
          // Section Info
          const Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text("Note de service"),
              subtitle: Text("N'oubliez pas de valider vos heures avant vendredi."),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeCard(String title, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {}, // À lier plus tard si besoin
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
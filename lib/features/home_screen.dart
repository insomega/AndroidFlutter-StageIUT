// lib/features/home_screen.dart

import 'package:flutter/material.dart';
import 'package:gbsystem_translations/gbsystem_application_strings.dart';

class GBSystem_HomeScreen extends StatelessWidget {
  const GBSystem_HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(GBSystem_Application_Strings.str_home_board, 
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
              _buildHomeCard(GBSystem_Application_Strings.str_planning, Icons.calendar_today, Colors.blue),
              _buildHomeCard(GBSystem_Application_Strings.str_menu_messages, Icons.message, Colors.orange),
              _buildHomeCard(GBSystem_Application_Strings.str_menu_absences, Icons.event_busy, Colors.green),
              _buildHomeCard(GBSystem_Application_Strings.str_documents, Icons.description, Colors.purple),
            ],
          ),
          const SizedBox(height: 20),
          
          // Section Info
          const Card(
            elevation: 2,
            child: ListTile(
              leading: Icon(Icons.info, color: Colors.blue),
              title: Text(GBSystem_Application_Strings.str_note_service),
              subtitle: Text(GBSystem_Application_Strings.str_note_service_msg),
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
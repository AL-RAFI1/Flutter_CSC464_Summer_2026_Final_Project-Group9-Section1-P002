import 'package:flutter/material.dart';
import '../models/match_model.dart';
import '../services/firestore_service.dart';
import '../widgets/history/match_history_tile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Match History Ledger',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Color(0xFF1E293B)),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
      ),
      body: StreamBuilder<List<MatchModel>>(
        stream: firestoreService.getMatches(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error loading history: ${snapshot.error}',
                style: const TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w500),
              ),
            );
          }

          final matches = snapshot.data ?? [];

          if (matches.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.history_toggle_off_rounded, size: 48, color: Color(0xFF6366F1)),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Matches Recorded Yet',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF334155)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Play a match to see your ledger fill up!',
                    style: TextStyle(color: Color(0xFF64748B)),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              return MatchHistoryTile(match: matches[index]);
            },
          );
        },
      ),
    );
  }
}
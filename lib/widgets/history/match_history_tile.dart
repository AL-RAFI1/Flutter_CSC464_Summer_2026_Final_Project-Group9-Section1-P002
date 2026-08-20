import 'package:flutter/material.dart';
import '../../models/match_model.dart';

class MatchHistoryTile extends StatelessWidget {
  final MatchModel match;

  const MatchHistoryTile({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    String winnerDisplay = 'Tie Game';
    Color badgeColor = const Color(0xFFF59E0B); // Amber for tie
    IconData statusIcon = Icons.handshake_rounded;

    if (match.winner == 'X') {
      winnerDisplay = '${match.player1} Won';
      badgeColor = const Color(0xFF4F46E5); // Indigo for X
      statusIcon = Icons.military_tech_rounded;
    } else if (match.winner == 'O') {
      winnerDisplay = '${match.player2} Won';
      badgeColor = const Color(0xFFE11D48); // Rose for O
      statusIcon = Icons.military_tech_rounded;
    }

    final formattedDate = '${match.createdAt.month}/${match.createdAt.day}/${match.createdAt.year} at ${match.createdAt.hour.toString().padLeft(2, '0')}:${match.createdAt.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Status Icon Avatar
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(statusIcon, color: badgeColor, size: 26),
            ),
            const SizedBox(width: 16),

            // Match Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${match.player1} vs ${match.player2}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded, size: 14, color: Color(0xFF94A3B8)),
                      const SizedBox(height: 4, width: 4),
                      Text(
                        formattedDate,
                        style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Winner Outcome Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                winnerDisplay,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: badgeColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
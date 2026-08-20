import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Player 1 Card with dynamic symbol
        _buildScoreCard(
          name: gameProvider.player1Name,
          symbol: '(${gameProvider.player1Symbol})',
          score: gameProvider.scoreX, // Tracks overall X wins
          color: gameProvider.player1Symbol == 'X' ? const Color(0xFF4F46E5) : const Color(0xFFE11D48),
        ),
        // Ties Card
        _buildScoreCard(
          name: 'Ties',
          symbol: '',
          score: gameProvider.scoreTie,
          color: const Color(0xFF64748B),
        ),
        // Player 2 Card with dynamic symbol
        _buildScoreCard(
          name: gameProvider.player2Name,
          symbol: '(${gameProvider.player2Symbol})',
          score: gameProvider.scoreO, // Tracks overall O wins
          color: gameProvider.player2Symbol == 'X' ? const Color(0xFF4F46E5) : const Color(0xFFE11D48),
        ),
      ],
    );
  }

  Widget _buildScoreCard({
    required String name,
    required String symbol,
    required int score,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            symbol.isEmpty ? name : '$name $symbol',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$score',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'player_model.dart';
import 'game_provider.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    final player1 = gameProvider.player1;
    final player2 = gameProvider.player2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Player 1 Scoreboard Card
        Expanded(
          child: _buildPlayerCard(
            player: player1,
            isActive: gameProvider.winner == '' && gameProvider.currentPlayer == player1.name,
            color: player1.symbol == 'X' ? const Color(0xFF4F46E5) : const Color(0xFFE11D48),
          ),
        ),
        const SizedBox(width: 8),
        // Ties Scoreboard Card
        _buildTieCard(scoreTie: gameProvider.scoreTie),
        const SizedBox(width: 8),
        // Player 2 Scoreboard Card
        Expanded(
          child: _buildPlayerCard(
            player: player2,
            isActive: gameProvider.winner == '' && gameProvider.currentPlayer == player2.name,
            color: player2.symbol == 'X' ? const Color(0xFF4F46E5) : const Color(0xFFE11D48),
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCard({
    required PlayerModel player,
    required bool isActive,
    required Color color,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isActive ? color.withOpacity(0.15) : Colors.black.withOpacity(0.03),
            blurRadius: isActive ? 12 : 10,
            spreadRadius: isActive ? 2 : 1,
          ),
        ],
        border: Border.all(
          color: isActive ? color : const Color(0xFFE2E8F0),
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  player.symbol,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  player.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            '${player.wins}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '${player.wins}W - ${player.losses}L',
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTieCard({required int scoreTie}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Ties',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$scoreTie',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Draws',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}

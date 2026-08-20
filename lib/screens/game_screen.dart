import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/game/board_grid.dart';
import '../widgets/game/scoreboard.dart';
import 'history_screen.dart';
import 'setup_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    // Trigger pop-up dialog when a game ends
    if (gameProvider.winner != '' && !_dialogShown) {
      _dialogShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWinnerDialog(context, gameProvider);
      });
    } else if (gameProvider.winner == '') {
      _dialogShown = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe Arena', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton.filledTonal(
              icon: const Icon(Icons.history_rounded, size: 22),
              tooltip: 'Match History',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryScreen()),
                );
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Turn Indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, spreadRadius: 2)],
                ),
                child: Text(
                  gameProvider.winner == '' ? "${gameProvider.currentPlayer}'s Turn" : "Round Over",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF475569)),
                ),
              ),
              const SizedBox(height: 20),

              // Scoreboard
              const Scoreboard(),
              const SizedBox(height: 24),

              // 3x3 Grid
              const BoardGrid(),
              const SizedBox(height: 32),

              // Controls: Restart Round, Switch Start, and Change Names
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      gameProvider.resetBoard();
                    },
                    icon: const Icon(Icons.replay_rounded),
                    label: const Text('Next Round'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      gameProvider.switchStartingPlayer();
                    },
                    icon: const Icon(Icons.swap_horiz_rounded),
                    label: const Text('Switch Start'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      gameProvider.resetBoard();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SetupScreen()),
                      );
                    },
                    icon: const Icon(Icons.people_outline_rounded),
                    label: const Text('Change Names'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF334155),
                      side: const BorderSide(color: Color(0xFFCBD5E1)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWinnerDialog(BuildContext context, GameProvider provider) {
    String message = "It's a Tie Game!";
    IconData icon = Icons.handshake_rounded;
    Color iconColor = Colors.orange;

    if (!provider.isTie) {
      String winnerName = provider.winner == 'X' ? provider.player1Name : provider.player2Name;
      message = "$winnerName Wins!";
      icon = Icons.emoji_events_rounded;
      iconColor = const Color(0xFF10B981); // Vibrant Emerald Green
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Icon(icon, size: 56, color: iconColor),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        content: const Text(
          'Match has been saved to your history ledger.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color(0xFF64748B)),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              provider.resetBoard();
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: const Text('Play Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }
}
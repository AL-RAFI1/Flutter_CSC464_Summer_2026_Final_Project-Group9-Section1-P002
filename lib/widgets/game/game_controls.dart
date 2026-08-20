import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';
import '../../screens/setup_screen.dart';

class GameControls extends StatelessWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        ElevatedButton.icon(
          onPressed: () => context.read<GameProvider>().resetBoard(),
          icon: const Icon(Icons.refresh),
          label: const Text('Next Round'),
        ),
        ElevatedButton.icon(
          onPressed: () => context.read<GameProvider>().switchStartingPlayer(),
          icon: const Icon(Icons.swap_horiz),
          label: const Text('Switch Start'),
        ),
        OutlinedButton.icon(
          onPressed: () {
            context.read<GameProvider>().resetBoard(); 
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SetupScreen()),
            );
          },
          icon: const Icon(Icons.people),
          label: const Text('Change Names'),
        ),
      ],
    );
  }
}
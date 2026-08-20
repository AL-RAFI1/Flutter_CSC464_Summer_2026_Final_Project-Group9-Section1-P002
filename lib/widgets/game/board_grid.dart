import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';
import '../board_cell.dart';

class BoardGrid extends StatelessWidget {
  const BoardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return BoardCell(
            index: index,
            cellValue: gameProvider.board[index],
          );
        },
      ),
    );
  }
}
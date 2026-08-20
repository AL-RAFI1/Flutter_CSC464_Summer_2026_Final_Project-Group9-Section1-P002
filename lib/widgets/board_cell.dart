import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class BoardCell extends StatelessWidget {
  final int index;
  final String cellValue;

  const BoardCell({super.key, required this.index, required this.cellValue});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => context.read<GameProvider>().makeMove(index),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
          ),
          child: Center(
            child: Text(
              cellValue,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                // 'X' is always Indigo, 'O' is always Rose
                color: cellValue == 'X' ? const Color(0xFF4F46E5) : const Color(0xFFE11D48),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
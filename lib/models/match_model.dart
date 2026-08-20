import 'package:cloud_firestore/cloud_firestore.dart';

class MatchModel {
  final String? id; // The Firestore document ID
  final String player1;
  final String player2;
  final String winner; // "X", "O", or "Tie"
  final List board; // Array of length 9
  final DateTime createdAt;

  MatchModel({
    this.id,
    required this.player1,
    required this.player2,
    required this.winner,
    required this.board,
    required this.createdAt,
  });

  // Translates Firestore JSON into this Dart object
  factory MatchModel.fromJson(Map json, String docId) {
    return MatchModel(
      id: docId,
      player1: json['player1'] ?? '',
      player2: json['player2'] ?? '',
      winner: json['winner'] ?? '',
      board: List.from(json['board'] ?? []),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }

  // Translates this Dart object into Firestore JSON
  Map toJson() {
    return {
      'player1': player1,
      'player2': player2,
      'winner': winner,
      'board': board,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
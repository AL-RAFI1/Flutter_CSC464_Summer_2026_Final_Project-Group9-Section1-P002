import 'package:flutter/material.dart';
import '../models/match_model.dart';
import '../services/firestore_service.dart';

class GameProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X'; 
  String _winner = '';
  bool _isTie = false;

  String _player1Name = 'Player 1';
  String _player2Name = 'Player 2';
  String _startingPlayer = 'X';

  int _scoreX = 0;
  int _scoreO = 0;
  int _scoreTie = 0;

  List<String> get board => _board;
  String get currentPlayer => _currentPlayer == 'X' ? _player1Name : _player2Name;
  String get winner => _winner;
  bool get isTie => _isTie;

  String get player1Name => _player1Name;
  String get player2Name => _player2Name;

  // Dynamic symbols that swap based on who starts the round!
  String get player1Symbol => _startingPlayer == 'X' ? 'X' : 'O';
  String get player2Symbol => _startingPlayer == 'X' ? 'O' : 'X';

  int get scoreX => _scoreX;
  int get scoreO => _scoreO;
  int get scoreTie => _scoreTie;

  void setPlayerNames(String p1, String p2) {
    _player1Name = p1;
    _player2Name = p2;
    _startingPlayer = 'X';
    _currentPlayer = 'X';
    resetBoard();
    notifyListeners();
  }

  void switchStartingPlayer() {
    _startingPlayer = _startingPlayer == 'X' ? 'O' : 'X';
    _currentPlayer = _startingPlayer;
    _board = List.filled(9, '');
    _winner = '';
    _isTie = false;
    notifyListeners();
  }

  void makeMove(int index) {
    if (_board[index] != '' || _winner != '') return;

    _board[index] = _currentPlayer;
    
    if (_checkWinner(_currentPlayer)) {
      _winner = _currentPlayer;
      if (_winner == 'X') {
        _scoreX++;
      } else {
        _scoreO++;
      }
      _saveMatchToFirestore();
    } else if (!_board.contains('')) {
      _isTie = true;
      _winner = 'Tie';
      _scoreTie++;
      _saveMatchToFirestore();
    } else {
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    }

    notifyListeners();
  }

  bool _checkWinner(String player) {
    const winConditions = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6],            // Diagonals
    ];

    for (var condition in winConditions) {
      if (_board[condition[0]] == player &&
          _board[condition[1]] == player &&
          _board[condition[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void resetBoard() {
    _board = List.filled(9, '');
    _currentPlayer = _startingPlayer;
    _winner = '';
    _isTie = false;
    notifyListeners();
  }

  Future<void> _saveMatchToFirestore() async {
    final match = MatchModel(
      id: '',
      player1: _player1Name,
      player2: _player2Name,
      winner: _winner,
      board: List.from(_board),
      createdAt: DateTime.now(),
    );
    await _firestoreService.saveMatchResult(match);
  }
}
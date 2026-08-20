import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/match_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Method called by GameProvider to save a match
  Future<void> saveMatchResult(MatchModel match) async {
    try {
      // Explicitly cast to Map<String, dynamic> to satisfy Firestore's type requirements
      await _db.collection('matches').add(match.toJson().cast<String, dynamic>());
    } catch (e) {
      print('Error saving match result: $e');
    }
  }

  // Stream of matches ordered by creation date (newest first) for the history screen
  Stream<List<MatchModel>> getMatches() {
    return _db
        .collection('matches')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MatchModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
            .toList());
  }
}
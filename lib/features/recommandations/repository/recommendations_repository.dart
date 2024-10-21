import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/recommendation_model.dart';


class RecommendationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RecommendationModel>> fetchRecommendations() async {
    final snapshot = await _firestore.collection('recommandations').get();
    return snapshot.docs.map((doc) => RecommendationModel.fromJson(doc.data())).toList();
  }
}
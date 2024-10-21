import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/electricity_data_model.dart';

class ElectricityRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ElectricityDataModel>> fetchElectricityData(String userId) async {
    List<ElectricityDataModel> allData = [];

    // Récupérer tous les équipements
    final equipmentSnapshot = await _firestore.collection('devices').where('uid', isEqualTo: userId) // Filtrer par user_id
        .get();

    for (var equipmentDoc in equipmentSnapshot.docs) {
      // Pour chaque équipement, récupérer les données électriques
      final dataSnapshot = await equipmentDoc.reference.collection('measurements').get();

      // Convertir les données en modèles
      for (var dataDoc in dataSnapshot.docs) {
        final data = dataDoc.data();
        allData.add(ElectricityDataModel(
          equipmentId: equipmentDoc.id,
          voltage: data['voltage'],
          power: data['power'],
          timestamp: (data['timestamp'] as Timestamp).toDate(),
        ));
      }
    }

    return allData;
  }
}
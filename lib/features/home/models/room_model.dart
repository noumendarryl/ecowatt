class RoomModel {
  final String? rid;
  final String name;
  final String? description;
  final int totalDevices;

  RoomModel({
    this.rid,
    required this.name,
    this.description,
    required this.totalDevices,
  });

  // Method to convert JSON data to RoomModel
  factory RoomModel.fromJson(Map<String, dynamic> data) {
    return RoomModel(
      rid: data['rid'],
      name: data['name'],
      description: data['description'],
      totalDevices: data['totalDevices'],
    );
  }

  // Method to convert RoomModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'rid': rid,
      'name': name,
      'description': description,
      'totalDevices': totalDevices,
    };
  }
}

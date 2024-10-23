class DeviceModel {
  String? did;
  String name;
  String type; // Type of device
  String rid; // Foreign key to the room
  String uid; // Foreign key to the user
  String? sensorId; // Foreign key to the sensor
  String? description;
  Map<String, dynamic>? measurements;
  bool isActive = false; // Device ON/OFF value
  bool isSmartDevice = false; // Flag for smart devices

  DeviceModel({
    this.did,
    required this.name,
    required this.type,
    required this.rid,
    required this.uid,
    this.sensorId,
    this.description,
    this.measurements,
    required this.isActive,
    required this.isSmartDevice,
  });

  // Convert from JSON
  factory DeviceModel.fromJson(Map<String, dynamic> data) {
    return DeviceModel(
      did: data['did'],
      name: data['name'],
      type: data['type'],
      rid: data['rid'],
      uid: data['uid'],
      sensorId: data['sensorId'],
      description: data['description'],
      measurements: data['measurements'],
      isActive: data['isActive'],
      isSmartDevice: data['isSmartDevice'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'did': did,
      'name': name,
      'type': type,
      'rid': rid,
      'uid': uid,
      'sensorId': sensorId,
      'description': description,
      'measurements': measurements,
      'isActive': isActive,
      'isSmartDevice': isSmartDevice,
    };
  }
}

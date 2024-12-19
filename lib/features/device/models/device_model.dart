class DeviceModel {
  String? did;
  String name;
  String type; // Type of device
  String rid; // Foreign key to the room
  String uid; // Foreign key to the user
  String? sid; // Foreign key to the sensor linked to the device
  String? description;
  bool isActive = false; // Device ON/OFF value
  bool isSmartDevice = false; // Flag for smart devices

  DeviceModel({
    this.did,
    required this.name,
    required this.type,
    required this.rid,
    required this.uid,
    this.sid,
    this.description,
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
      sid: data['sid'],
      description: data['description'],
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
      'sid': sid,
      'description': description,
      'isActive': isActive,
      'isSmartDevice': isSmartDevice,
    };
  }

  DeviceModel copyWith({
    String? did,
    String? name,
    String? type,
    String? rid,
    String? uid,
    String? sid,
    String? description,
    bool? isActive,
    bool? isSmartDevice,
  }) {
    return DeviceModel(
      did: did ?? this.did,
      name: name ?? this.name,
      type: type ?? this.type,
      rid: rid ?? this.rid,
      uid: uid ?? this.uid,
      sid: sid ?? this.sid,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      isSmartDevice: isSmartDevice ?? this.isSmartDevice,
    );
  }
}

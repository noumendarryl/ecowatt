class DeviceTypeModel {
  int? tid;
  String name;

  DeviceTypeModel({
    this.tid,
    required this.name,
  });

  // Convert from JSON
  factory DeviceTypeModel.fromJson(Map<String, dynamic> data) {
    return DeviceTypeModel(
      tid: data['tid'],
      name: data['name'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'tid': tid,
      'name': name,
    };
  }
}

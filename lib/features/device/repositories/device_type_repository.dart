import '../models/device_type_model.dart';

class DeviceTypeRepository {
  List<DeviceTypeModel> getDeviceTypes() {
    return [
      DeviceTypeModel(tid: 1, name: 'Smart TV'),
      DeviceTypeModel(tid: 2, name: 'AC'),
      DeviceTypeModel(tid: 3, name: 'Wi-Fi'),
      DeviceTypeModel(tid: 4, name: 'Lamp'),
      DeviceTypeModel(tid: 5, name: 'Fridge'),
      DeviceTypeModel(tid: 6, name: 'Fan'),
      DeviceTypeModel(tid: 7, name: 'Washing Machine'),
      DeviceTypeModel(tid: 8, name: 'Computer'),
    ];
  }
}

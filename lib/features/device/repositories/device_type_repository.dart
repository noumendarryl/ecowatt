import '../models/device_type_model.dart';

class DeviceTypeRepository {
  List<DeviceTypeModel> getDeviceTypes() {
    return [
      DeviceTypeModel(tid: 1, name: 'TVs'),
      DeviceTypeModel(tid: 2, name: 'ACs'),
      DeviceTypeModel(tid: 3, name: 'Wi-Fi'),
      DeviceTypeModel(tid: 4, name: 'Lamps'),
      DeviceTypeModel(tid: 5, name: 'Fridges'),
      DeviceTypeModel(tid: 6, name: 'Fans'),
      DeviceTypeModel(tid: 7, name: 'Ovens'),
      DeviceTypeModel(tid: 8, name: 'Lighting'),
      DeviceTypeModel(tid: 9, name: 'Irons'),
      DeviceTypeModel(tid: 10, name: 'Printers'),
      DeviceTypeModel(tid: 11, name: 'Dryers'),
      DeviceTypeModel(tid: 12, name: 'Consoles'),
      DeviceTypeModel(tid: 13, name: 'Sensors'),
      DeviceTypeModel(tid: 14, name: 'Monitors'),
      DeviceTypeModel(tid: 15, name: 'Soundbars'),
      DeviceTypeModel(tid: 16, name: 'Cameras'),
    ];
  }
}

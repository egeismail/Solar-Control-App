import 'package:flutter_blue/flutter_blue.dart';

class globalContext {
  static final globalContext _instance = globalContext._internal();

  factory globalContext() => _instance;

  globalContext._internal() {
    flutterBlue = FlutterBlue.instance;
    bluetoothDevices = <BluetoothDevice>[];
    DEBUG_MODE = true;
  }
  bool DEBUG_MODE = false;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> bluetoothDevices = <BluetoothDevice>[];
}

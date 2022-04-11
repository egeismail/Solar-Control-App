import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

Widget SettingsBluetoothWidget(context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Bluetooth"),
    ),
    body: BlueToothSearchWidget(),
  );
}

class BlueToothSearchWidget extends StatefulWidget {
  BlueToothSearchWidget({Key? key}) : super(key: key);

  @override
  State<BlueToothSearchWidget> createState() => _BlueToothSearchWidgetState();
}

class _BlueToothSearchWidgetState extends State<BlueToothSearchWidget> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> bluetoothDevices = <BluetoothDevice>[];
  _addDeviceTolist(final BluetoothDevice device) {
    if (!bluetoothDevices.contains(device)) {
      setState(() {
        bluetoothDevices.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });
    flutterBlue.scanResults.listen((results) {
      setState(() {
        for (ScanResult result in results) {
          _addDeviceTolist(result.device);
        }
      });
    });
    flutterBlue.startScan(timeout: Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ...bluetoothDevices.map(
          (device) => ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
          ),
        )
      ],
    );
  }
}

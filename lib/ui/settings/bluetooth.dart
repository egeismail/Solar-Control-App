import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:solarcontrol/contexts/globalContext.dart';

Widget SettingsBluetoothWidget(context) {
  globalContext bsvc = globalContext();
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
  globalContext bsvc = globalContext();
  _addDeviceTolist(final BluetoothDevice device) {
    if (!bsvc.bluetoothDevices.contains(device)) {
      setState(() {
        bsvc.bluetoothDevices.add(device);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    bsvc.flutterBlue.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        _addDeviceTolist(device);
      }
    });

    // bsvc.flutterBlue.scanResults.listen((results) {
    //   setState(() {
    //     for (ScanResult result in results) {
    //       _addDeviceTolist(result.device);
    //       print('${result.device.name} found! rssi: ${result.rssi}');
    //     }
    //     print('result found ${results.length}');
    //   });
    // });
    // bsvc.flutterBlue.startScan(
    //     timeout: Duration(seconds: 25), scanMode: ScanMode.lowLatency);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: ListView.builder(
            itemBuilder: (ctx, idx) {
              var device = bsvc.bluetoothDevices[idx];
              return ListTile(
                title: Text(device.name),
                subtitle: Text(device.id.toString()),
              );
            },
            itemCount: bsvc.bluetoothDevices.length),
        onRefresh: () async {
          // bsvc.flutterBlue.startScan(timeout: Duration(seconds: 5));

          return Future<void>.delayed(const Duration(seconds: 5));
        });
  }
}

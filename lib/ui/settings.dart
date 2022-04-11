import 'package:flutter/material.dart';
import 'settings/bluetooth.dart';

Widget SettingsWidget(ctx) {
  return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text("Bluetooth"),
              subtitle: const Text("You can configure bluetooth settings."),
              minLeadingWidth: 0,
              leading: Container(
                height: double.infinity,
                child: Icon(Icons.bluetooth, color: Colors.blue[600]),
              ),
              onTap: () {
                Navigator.of(ctx).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return SettingsBluetoothWidget(context);
                }));
              },
            ),
            Divider(),
          ],
        ),
      ));
}

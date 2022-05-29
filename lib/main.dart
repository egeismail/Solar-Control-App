import 'package:flutter/material.dart';
import 'package:solarcontrol/ui/settings.dart';

import 'ui/control.dart';
import 'ui/analyze.dart';

void main() {
  runApp(const wordMain());
}

class wordMain extends StatelessWidget {
  const wordMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "OptiSun Controller",
        home: SolarTab(),
        theme: ThemeData(
          appBarTheme: const AppBarTheme(),
          brightness: Brightness.dark,
        ));
  }
}

class SolarTab extends StatefulWidget {
  SolarTab({Key? key}) : super(key: key);

  @override
  State<SolarTab> createState() => _SolarTabState();
}

class _SolarTabState extends State<SolarTab> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  PreferredSizeWidget currentAppBar(ctx) {
    return AppBar(
      title: const Text("OptiSun"),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.of(ctx)
                .push(MaterialPageRoute<void>(builder: (BuildContext context) {
              return SettingsWidget(context);
            }));
          },
          icon: const Icon(Icons.settings),
        )
      ],
      bottom: TabBar(
        controller: _tabController,
        tabs: const <Tab>[
          Tab(
            text: "Control",
            icon: Icon(Icons.gamepad_outlined),
          ),
          Tab(
            text: "Analyze",
            icon: Icon(Icons.addchart_outlined),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: currentAppBar(context),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ControlWidget(context),
            AnalyzeWidget(),
          ],
        ));
  }
}

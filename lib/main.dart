import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';

void main() {
  runApp(MaterialApp(home: Home(), theme: ThemeData.dark()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<WifiNetwork> wifiList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wifi IOT test app"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        WiFiForIoTPlugin.setWiFiAPEnabled(false);
                        wifiList = await WiFiForIoTPlugin.loadWifiList();
                        print(wifiList);
                        setState(() {});
                      },
                      child: Text("Get wifi list")),
                  SizedBox(height: 10),
                ] +
                wifiList
                    .map<Widget>((e) => ListTile(
                          title: Text(e.ssid ?? "Unknown ssid"),
                          onTap: () async {
                            print(e.ssid!);
                            print(await WiFiForIoTPlugin.connect(e.ssid!,
                                password: '12345678',
                                joinOnce: true,
                                // withInternet: true,
                                security: NetworkSecurity.WPA));
                          },
                        ))
                    .toList() +
                <Widget>[
                  SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () async {
                        WiFiForIoTPlugin.setWiFiAPPreSharedKey("12345678");
                        WiFiForIoTPlugin.setWiFiAPSSID("Test Android AP");
                        WiFiForIoTPlugin.setWiFiAPEnabled(true);
                      },
                      child: Text("Turn hotspot on")),
                ],
          ),
        ),
      ),
    );
  }
}

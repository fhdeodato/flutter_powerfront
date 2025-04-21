import 'package:flutter/material.dart';
import 'package:flutter_powerfront/flutter_powerfront.dart';
import 'package:flutter_powerfront_example/helpers.dart';

void main() {
  // initilizing everthing...
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _flutterPowerfrontPlugin = FlutterPowerfront();

  @override
  void initState() {
    _flutterPowerfrontPlugin.onConnected(powerFrontOnConnected);
    _flutterPowerfrontPlugin.onChatClose(powerFrontOnChatClose);
    _flutterPowerfrontPlugin.onChatMinimise(powerFrontOnChatMinimise);
    _flutterPowerfrontPlugin.onChatEnded(powerFrontOnChatEnded);
    _flutterPowerfrontPlugin.onChatAvailable(powerFrontonChatAvailable);
    _flutterPowerfrontPlugin.onChatMessage(powerFrontOnChatMessage);
    _flutterPowerfrontPlugin.onDisconnected(powerFrontonDisconnected);
    _flutterPowerfrontPlugin.onError(powerFrontOnError);
    _flutterPowerfrontPlugin.onLinkTapped(powerFrontOnLinkTapped);
    super.initState();
  }

  void powerFrontOnConnected() {
    debugLog("onConnected executed");
  }

  void powerFrontOnLinkTapped(String url) {
    debugLog("onLinkTapped executed, url -> $url");
  }

  void powerFrontOnError(String message, int statusCode) {
    debugLog("onError executed");
  }

  void powerFrontOnChatClose() {
    debugLog("onChatClose executed");
  }

  void powerFrontOnChatMinimise() {
    debugLog("onChatMinimise executed");
  }

  void powerFrontonChatAvailable(bool available) {
    debugLog("onChatAvailable executed");
  }

  void powerFrontOnChatEnded(InsideEndedBy endedBy) {
    debugLog("onChatEnded executed, endedBy -> ${endedBy.name.toLowerCase()}");
  }

  void powerFrontOnChatMessage(String messageText, bool proactiveChat,
      String senderName, String? operatorImageUrl) {
    debugLog("powerFrontOnChatMessage executed, messageText -> ${messageText}");
  }

  void powerFrontonDisconnected() {
    debugLog("onDisconnected executed");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                InsideInitConfiguration initConfig = InsideInitConfiguration(
                  domainURL: 'https://us-sandbox-live.inside-graph.com/',
                  accountKey: 'IN-1001179', //'IN-XXXYYYW',
                  appName: 'APPNAME',
                  mobileSiteURL: 'https://www.fashionphile.us/',
                );

                _flutterPowerfrontPlugin.init(initConfig);
              },
              child: const Text(
                "init()",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _flutterPowerfrontPlugin.setView();
              },
              child: const Text(
                "trackView()",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _flutterPowerfrontPlugin.push();
              },
              child: const Text(
                "a push()",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _flutterPowerfrontPlugin.presentView();
              },
              child: const Text(
                "presentView()",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

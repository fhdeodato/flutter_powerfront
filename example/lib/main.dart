import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_powerfront/flutter_powerfront.dart';
import 'package:flutter_powerfront_example/app_config.dart';
import 'package:flutter_powerfront_example/helpers.dart';

void main() async {
  // initilizing everthing...
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

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
    _flutterPowerfrontPlugin.onDisconnected(powerFrontOnDisconnected);
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
    // _flutterPowerfrontPlugin.disconnect();
    dismissPanel();
  }

  void powerFrontOnChatMinimise() {
    debugLog("onChatMinimise executed");
    dismissPanel();
  }

  void powerFrontonChatAvailable(bool available) {
    debugLog("onChatAvailable executed");
  }

  void powerFrontOnChatEnded(InsideEndedBy endedBy) {
    debugLog("onChatEnded executed, endedBy -> ${endedBy.name.toLowerCase()}");
    _flutterPowerfrontPlugin.disconnect();
    dismissPanel();
  }

  void powerFrontOnChatMessage(String messageText, bool proactiveChat,
      String senderName, String? operatorImageUrl) {
    debugLog("powerFrontOnChatMessage executed, messageText -> ${messageText}");
  }

  void powerFrontOnDisconnected() {
    debugLog("onDisconnected executed");
  }

  void dismissPanel() {
    _flutterPowerfrontPlugin.dismiss();
    if (Platform.isAndroid) {
      _flutterPowerfrontPlugin.detachChatPane();
    }
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
                    domainURL: AppConfig.powerfrontDomainUrl,
                    accountKey: AppConfig.powerfrontAccountKey,
                    appName: AppConfig.powerfrontAppName,
                    mobileSiteURL: AppConfig.powerfrontMobileSiteUrl,
                    isLoadingEnabled: false // disable the default loader
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
                _flutterPowerfrontPlugin.pushView();
              },
              child: const Text(
                "a push()",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                int top = 0;
                int bottom = 0;
                if (Platform.isAndroid) {
                  top = MediaQuery.of(context).padding.top.toInt() + kToolbarHeight.toInt() + 10;
                  bottom = MediaQuery.of(context).padding.bottom.toInt() + 1;
                }
                _flutterPowerfrontPlugin.presentView(top: top, bottom: bottom);
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

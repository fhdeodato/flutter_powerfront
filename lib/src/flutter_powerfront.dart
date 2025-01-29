import 'package:flutter/widgets.dart';
import 'package:flutter_powerfront/flutter_powerfront.dart';
import 'flutter_powerfront_platform_interface.dart';

// Remember that this is the way the final app will communicate
// so keep the methods simple and self explanatory
class FlutterPowerfront {
  /// Powerfront
  Future<void> init(InsideInitConfiguration config) async {
    await FlutterPowerfrontPlatform.instance.init(config);
  }

  Future<bool?> setView() async {
    return FlutterPowerfrontPlatform.instance.setView();
  }

  Future<bool?> push() async {
    return FlutterPowerfrontPlatform.instance.push();
  }

  Future<void> pushView() async {
    return FlutterPowerfrontPlatform.instance.pushView();
  }

  Future<void> presentView() async {
    return FlutterPowerfrontPlatform.instance.presentView();
  }

  // Events listeners
  Future<void> onConnected(VoidCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnConnected(callback);
  }

  Future<void> onDisconnected(VoidCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnDisconnected(callback);
  }

  Future<void> onChatClose(VoidCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnChatClose(callback);
  }

  Future<void> onChatMinimise(VoidCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnChatMinimise(callback);
  }

  Future<void> onChatEnded(Function(InsideEndedBy endedBy) callback) async {
    return FlutterPowerfrontPlatform.instance.setOnChatEnded(callback);
  }

  Future<void> onChatAvailable(Function(bool available) callback) async {
    return FlutterPowerfrontPlatform.instance.setOnChatAvailable(callback);
  }

  Future<void> onChatMessage(ChatMessageCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnChatMessage(callback);
  }

  Future<void> onError(ErrorCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnError(callback);
  }

  Future<void> onLinkTapped(Function(String url) callback) async {
    return FlutterPowerfrontPlatform.instance.setOnLinkTapped(callback);
  }

  Future<void> onAddToBasket(AddToBasketCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnAddToBasket(callback);
  }

  Future<void> onViewProductDetails(ViewProductDetailsCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnViewProductDetails(callback);
  }


  Future<int> getUnreadMessagesCount() async {
    return FlutterPowerfrontPlatform.instance.getUnreadMessagesCount();
  }
}

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

  Future<void> dismiss() async {
    await FlutterPowerfrontPlatform.instance.dismiss();
  }

  /// detachChatPane is ANDROID ONLY
  /// calling it on iOS will result in unimplemented error
  Future<void> detachChatPane() async {
    await FlutterPowerfrontPlatform.instance.detachChatPane();
  }

  Future<void> disconnect() async {
    await FlutterPowerfrontPlatform.instance.disconnect();
  }

  Future<bool?> setView() async {
    return FlutterPowerfrontPlatform.instance.setView();
  }

  Future<bool?> push() async {
    return FlutterPowerfrontPlatform.instance.push();
  }

  /// PushView receives two parameters top and bottom
  /// those parameters only affects android rendering of the main chat
  /// they are used as a top and bottom margin of the activity
  /// the sdk request to both be set, so you may need to add 1 for bottom to not impact your design.
  Future<void> pushView({int top = 0, int bottom = 0}) async {
    return FlutterPowerfrontPlatform.instance
        .pushView(top: top, bottom: bottom);
  }

  Future<void> presentView({int top = 0, int bottom = 0}) async {
    return FlutterPowerfrontPlatform.instance
        .presentView(top: top, bottom: bottom);
  }

  /// CALL THIS ONLY AFTER INIT
  Future<void> showHideDefaultLoader(bool isEnabled) {
    return FlutterPowerfrontPlatform.instance.showHideDefaultLoader(isEnabled);
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

  Future<void> onChatVisible(VoidCallback callback) async {
    return FlutterPowerfrontPlatform.instance.setOnChatVisible(callback);
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

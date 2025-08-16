import 'dart:ui';

import 'package:flutter_powerfront/flutter_powerfront.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_powerfront/src/flutter_powerfront_platform_interface.dart';
import 'package:flutter_powerfront/src/flutter_powerfront_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPowerfrontPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPowerfrontPlatform {

  @override
  Future<bool?> init(InsideInitConfiguration config) {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<bool?> dismiss() {
    // TODO: implement init
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> push() {
    // TODO: implement push
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> setView() {
    // TODO: implement trackView
    throw UnimplementedError();
  }

  @override
  Future<void> setOnAddToBasket(AddToBasketCallback callback) {
    // TODO: implement onAddToBasket
    throw UnimplementedError();
  }

  @override
  Future<void> setOnChatClose(VoidCallback callback) {
    // TODO: implement onChatClose
    throw UnimplementedError();
  }

  @override
  Future<void> setOnChatEnded(Function(InsideEndedBy endedBy) callback) {
    // TODO: implement onChatEnded
    throw UnimplementedError();
  }

  @override
  Future<void> setOnChatMessage(ChatMessageCallback callback) {
    // TODO: implement onChatMessage
    throw UnimplementedError();
  }

  @override
  Future<void> setOnChatMinimise(VoidCallback callback) {
    // TODO: implement onChatMinimise
    throw UnimplementedError();
  }

  @override
  Future<void> setOnConnected(VoidCallback callback) {
    // TODO: implement onConnected
    throw UnimplementedError();
  }

  @override
  Future<void> setOnDisconnected(VoidCallback callback) {
    // TODO: implement onDisconnected
    throw UnimplementedError();
  }

  @override
  Future<void> setOnError(ErrorCallback callback) {
    // TODO: implement onError
    throw UnimplementedError();
  }

  @override
  Future<bool> setOnLinkTapped(Function(String url) callback) {
    // TODO: implement onLinkTapped
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> abandonCart() {
    // TODO: implement abandonCart
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> addItemToCart() {
    // TODO: implement addItemToCart
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> clearCart() {
    // TODO: implement clearCart
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> completeOrder() {
    // TODO: implement completeOrder
    throw UnimplementedError();
  }
  
  // @override
  // Future<bool?> getUnreadMessagesCount() {
  //   // TODO: implement getUnreadMessagesCount
  //   throw UnimplementedError();
  // }
  
  @override
  Future<bool?> presentView({int top = 0, int bottom = 0}) {
    // TODO: implement presentView
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> pushView({int top = 0, int bottom = 0}) {
    // TODO: implement pushView
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> removeItemFromCart() {
    // TODO: implement removeItemFromCart
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> setCart() {
    // TODO: implement setCart
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> setLoaderBackgroundColor(String color) {
    // TODO: implement setLoaderBackgroundColor
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> setUser() {
    // TODO: implement setUser
    throw UnimplementedError();
  }
  
  @override
  Future<bool?> updateItemToCart() {
    // TODO: implement updateItemToCart
    throw UnimplementedError();
  }
  
  @override
  void setOnChatAvailable(Function(bool available) callback) {
    // TODO: implement setOnChatAvailable
  }
  
  @override
  void setOnViewProductDetails(ViewProductDetailsCallback callback) {
    // TODO: implement setOnViewProductDetails
  }
  
  @override
  Future<int> getUnreadMessagesCount() {
    // TODO: implement getUnreadMessagesCount
    throw UnimplementedError();
  }
  
  @override
  Future<void> disconnect() {
    // TODO: implement disconnect
    throw UnimplementedError();
  }
  
  @override
  Future<void> detachChatPane() {
    // TODO: implement detachChatPane
    throw UnimplementedError();
  }
  
  @override
  Future<void> showHideDefaultLoader(bool isEnabled) {
    // TODO: implement showHideDefaultLoader
    throw UnimplementedError();
  }
}

void main() {
  final FlutterPowerfrontPlatform initialPlatform = FlutterPowerfrontPlatform.instance;

  test('$MethodChannelFlutterPowerfront is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPowerfront>());
  });

  // test('getPlatformVersion', () async {
  //   FlutterPowerfront flutterPowerfrontPlugin = FlutterPowerfront();
  //   MockFlutterPowerfrontPlatform fakePlatform = MockFlutterPowerfrontPlatform();
  //   FlutterPowerfrontPlatform.instance = fakePlatform;

  //   expect(await flutterPowerfrontPlugin.getPlatformVersion(), '42');
  // });
}

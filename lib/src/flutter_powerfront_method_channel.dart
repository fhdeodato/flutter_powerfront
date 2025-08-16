import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_powerfront/flutter_powerfront.dart';
import 'package:flutter_powerfront/src/helpers/helpers.dart';

import 'flutter_powerfront_platform_interface.dart';

/// An implementation of [FlutterPowerfrontPlatform] that uses method channels.
class MethodChannelFlutterPowerfront extends FlutterPowerfrontPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_powerfront');

  // callback definitions
  Function(InsideEndedBy endedBy)? onChatEnded;
  Function(bool available)? onChatAvailable;
  Function(String url)? onLinkTapped;
  ChatMessageCallback? onChatMessage;
  AddToBasketCallback? onAddToBasket;
  ViewProductDetailsCallback? onViewProductDetails;
  ErrorCallback? onError;
  VoidCallback? onConnected;
  VoidCallback? onDisconnected;
  VoidCallback? onChatMinimise;
  VoidCallback? onChatClose;
  VoidCallback? onChatVisible;

  /// Powerfront

  // -----------------------------------------------------
  // MARK: init
  // -----------------------------------------------------
  @override
  Future<void> init(InsideInitConfiguration config) async {
    config.verifyConfiguration();

    // handle the listeners
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onChatEnded":
          _handleOnChatEnded(call);
          break;
        case "onConnected":
          _handleOnConnected(call);
          break;
        case "onChatMinimise":
          _handleOnChatMinimise(call);
          break;
        case "onChatClose":
          return _handleOnChatClose(call);
        case "onDisconnected":
          _handleOnDisconnected(call);
          break;
        case "onChatAvailable":
          _handleOnChatAvailable(call);
          break;
        case "onError":
          _handleOnError(call);
          break;
        case "onLinkTapped":
          _handleOnLinkTapped(call);
          break;
        case "onChatMessage":
          _handleOnChatMessage(call);
          break;
        case "onAddToBasket":
          _handleOnAddToBasket(call);
          break;
        case "onViewProductDetails":
          _handleOnViewProductDetails(call);
          break;
        case "onChatVisible":
          _handleOnChatVisible(call);
          break;
      }
    });

    await methodChannel.invokeMethod<bool>('init', config.toJson());
  }

  // -----------------------------------------------------
  // MARK: dismiss
  // -----------------------------------------------------
  @override
  Future<bool?> dismiss() async {
    final version = await methodChannel.invokeMethod<bool>('dismiss');
    return version;
  }

  // -----------------------------------------------------
  // MARK: detachChatPane
  // -----------------------------------------------------
  @override
  Future<bool?> detachChatPane() async {
    final version = await methodChannel.invokeMethod<bool>('detachChatPane');
    return version;
  }

  // -----------------------------------------------------
  // MARK: disconnect
  // -----------------------------------------------------
  @override
  Future<bool?> disconnect() async {
    final result = await methodChannel.invokeMethod<bool>('disconnect');
    return result;
  }

  // -----------------------------------------------------
  // MARK: setView
  // -----------------------------------------------------
  @override
  Future<bool?> setView() async {
    final version = await methodChannel.invokeMethod<bool>('  ');
    return version;
  }

  // -----------------------------------------------------
  // MARK: push
  // -----------------------------------------------------
  @override
  Future<bool?> push() async {
    final version = await methodChannel.invokeMethod<bool>('push');
    return version;
  }

  // -----------------------------------------------------
  // MARK: pushView
  // -----------------------------------------------------
  @override
  Future<void> pushView({int top = 0, int bottom = 0}) async {
    Map<dynamic, dynamic> config = {
      "top": top,
      "bottom": bottom,
    };
    await methodChannel.invokeMethod<bool>('pushView', config);
  }

  // -----------------------------------------------------
  // MARK: presentView
  // -----------------------------------------------------
  @override
  Future<void> presentView({int top = 0, int bottom = 0}) async {
    Map<dynamic, dynamic> config = {
      "top": top,
      "bottom": bottom,
    };
    await methodChannel.invokeMethod<bool>('presentView',config);
  }

  @override
  Future<int> getUnreadMessagesCount() async {
    return await methodChannel.invokeMethod<int>('getUnreadMessagesCount') ?? 0;
  }
  //
  //
  //
  // MARK: Powerfront Events
  //
  //
  //

  // -----------------------------------------------------
  // MARK: onChatEnded
  // -----------------------------------------------------
  @override
  void setOnChatEnded(Function(InsideEndedBy endedBy) callback) {
    onChatEnded = callback;
  }

  Future<void> _handleOnChatEnded(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onChatEnded") return;

      // if not callback defined, ignore the call
      if (onChatEnded == null) return;

      _argumentValidation(
        "onChatEnded",
        call.arguments,
        {"endedBy": String},
      );

      final args = call.arguments as Map;
      // return the correct enum based on the received string
      final endedByString = args["endedBy"].toString().toLowerCase();
      InsideEndedBy endedBy;

      switch (endedByString) {
        case "operator":
          endedBy = InsideEndedBy.operator;
          break;
        case "visitor":
          endedBy = InsideEndedBy.visitor;
          break;
        default:
          throw ArgumentError("Unknown 'endedBy' value: $endedByString");
      }

      // calling the callback
      onChatEnded!(endedBy);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onChatEnded: $e");
      debugLog(stackTrace.toString());
    }
  }

  // -----------------------------------------------------
  // MARK: onConnected
  // -----------------------------------------------------
  @override
  void setOnConnected(VoidCallback callback) async {
    onConnected = callback;
  }

  Future<void> _handleOnConnected(MethodCall call) async {
    // validation for the current method
    if (call.method != "onConnected") return;

    // if not callback defined, ignore the call
    if (onConnected == null) return;

    onConnected!();
  }

  // -----------------------------------------------------
  // MARK: onChatMinimise
  // -----------------------------------------------------
  @override
  void setOnChatMinimise(VoidCallback callback) async {
    onChatMinimise = callback;
  }

  void _handleOnChatMinimise(MethodCall call) async {
    // validation for the current method
    if (call.method != "onChatMinimise") return;

    // if not callback defined, ignore the call
    if (onChatMinimise == null) return;

    onChatMinimise!();
  }

  // -----------------------------------------------------
  // MARK: onChatClose
  // -----------------------------------------------------
  @override
  void setOnChatClose(VoidCallback callback) {
    onChatClose = callback;
  }

  void _handleOnChatClose(MethodCall call) async {
    // validation for the current method
    if (call.method != "onChatClose") return;

    // if not callback defined, ignore the call
    if (onChatClose == null) return;

    onChatClose!();

    return;
  }

  // -----------------------------------------------------
  // MARK: onDisconnected
  // -----------------------------------------------------
  @override
  void setOnDisconnected(VoidCallback callback) async {
    onDisconnected = callback;
  }

  Future<void> _handleOnDisconnected(MethodCall call) async {
    // validation for the current method
    if (call.method != "onDisconnected") return;

    // if not callback defined, ignore the call
    if (onDisconnected == null) return;

    onDisconnected!();
  }

  // -----------------------------------------------------
  // MARK: onChatAvailable
  // -----------------------------------------------------
  @override
  void setOnChatAvailable(Function(bool available) callback) {
    onChatAvailable = callback;
  }

  Future<void> _handleOnChatAvailable(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onChatAvailable") return;

      // if not callback defined, ignore the call
      if (onChatAvailable == null) return;

      _argumentValidation(
        "onChatAvailable",
        call.arguments,
        {"available": bool},
      );

      final args = call.arguments as Map;
      final available =
          bool.tryParse(args["available"].toString().toLowerCase()) ?? false;

      // calling the callback
      onChatAvailable!(available);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onChatAvailable: $e");
      debugLog(stackTrace.toString());
    }
  }

    // -----------------------------------------------------
  // MARK: onChatVisible
  // -----------------------------------------------------
  @override
  void setOnChatVisible(VoidCallback callback) {
    onChatVisible = callback;
  }

  Future<void> _handleOnChatVisible(MethodCall call) async {
    // validation for the current method
    if (call.method != "onChatVisible") return;

    // if not callback defined, ignore the call
    if (onChatVisible == null) return;

    // calling the callback
    onChatVisible!();
  }

  // -----------------------------------------------------
  // MARK: onError
  // -----------------------------------------------------
  @override
  void setOnError(ErrorCallback callback) {
    onError = callback;
  }

  Future<void> _handleOnError(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onError") return;

      // if not callback defined, ignore the call
      if (onChatAvailable == null) return;

      _argumentValidation(
        "onError",
        call.arguments,
        {
          "message": String,
          "statusCode": String,
        },
      );

      final args = call.arguments as Map;
      final message = args["message"].toString();
      int statusCode = int.tryParse(args["statusCode"].toString()) ?? 0;

      // calling the callback
      onError!(message, statusCode);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onError: $e");
      debugLog(stackTrace.toString());
    }
  }

  // -----------------------------------------------------
  // MARK: onLinkTapped
  // -----------------------------------------------------
  @override
  void setOnLinkTapped(Function(String url) callback) {
    onLinkTapped = callback;
  }

  Future<void> _handleOnLinkTapped(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onLinkTapped") return;

      // if not callback defined, ignore the call
      if (onLinkTapped == null) return;

      _argumentValidation(
        "onLinkTapped",
        call.arguments,
        {"url": String},
      );

      final args = call.arguments as Map;
      // return the correct enum based on the received string
      final url = args["url"].toString();

      // calling the callback
      onLinkTapped!(url);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onLinkTapped: $e");
      debugLog(stackTrace.toString());
    }
  }

  // -----------------------------------------------------
  // MARK: onChatMessage
  // -----------------------------------------------------
  @override
  void setOnChatMessage(ChatMessageCallback callback) {
    onChatMessage = callback;
  }

  Future<void> _handleOnChatMessage(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onChatMessage") return;

      // if not callback defined, ignore the call
      if (onChatMessage == null) return;

      _argumentValidation(
        "onChatMessage",
        call.arguments,
        {
          "messageText": String,
          "proactiveChat": bool,
          "senderName": String,
          // "operatorImageUrl": String // this is not mandatory...
        },
      );

      final args = call.arguments as Map;
      // return the correct enum based on the received string
      final messageText = args["messageText"].toString();
      final proactiveChat =
          bool.tryParse(args["proactiveChat"].toString()) == true;
      final senderName = args["senderName"].toString();
      final operatorImageUrl = args["operatorImageUrl"]?.toString();

      // calling the callback
      onChatMessage!(messageText, proactiveChat, senderName, operatorImageUrl);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onChatMessage: $e");
      debugLog(stackTrace.toString());
    }
  }

  // -----------------------------------------------------
  // MARK: onAddToBasket
  // -----------------------------------------------------
  @override
  void setOnAddToBasket(AddToBasketCallback callback) {
    onAddToBasket = callback;
  }

  Future<void> _handleOnAddToBasket(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onAddToBasket") return;

      // if not callback defined, ignore the call
      if (onAddToBasket == null) return;

      _argumentValidation(
        "onAddToBasket",
        call.arguments,
        {
          "productId": String,
          "skuId": String,
        },
      );

      final args = call.arguments as Map;
      // return the correct enum based on the received string
      final productId = args["productId"].toString();
      final skuId = args["skuId"].toString();

      // calling the callback
      onAddToBasket!(productId, skuId);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onAddToBasket: $e");
      debugLog(stackTrace.toString());
    }
  }

  // -----------------------------------------------------
  // MARK: onViewProductDetails
  // -----------------------------------------------------
  @override
  void setOnViewProductDetails(ViewProductDetailsCallback callback) {
    onViewProductDetails = callback;
  }

  Future<void> _handleOnViewProductDetails(MethodCall call) async {
    try {
      // validation for the current method
      if (call.method != "onViewProductDetails") return;

      // if not callback defined, ignore the call
      if (onViewProductDetails == null) return;

      _argumentValidation(
        "onViewProductDetails",
        call.arguments,
        {
          "productId": String,
          "skuId": String,
        },
      );

      final args = call.arguments as Map;
      // return the correct enum based on the received string
      final productId = args["productId"].toString();
      final skuId = args["skuId"].toString();

      // calling the callback
      onViewProductDetails!(productId, skuId);
    } catch (e, stackTrace) {
      // Log de erros para diagnóstico
      debugLog("Error in onAddToBasket: $e");
      debugLog(stackTrace.toString());
    }
  }

  // -----------------------------------------------------
  // MARK: _argumentValidation
  // -----------------------------------------------------

  /// Validates the presence and types of required arguments in a map.
  ///
  /// - [method]: Method call to be validated.
  /// - [call]: MethodCall to get the arguments and the method.
  /// - [expectedArgs]: A list of expected arguments with their types as a Map<String, Type>.
  ///
  /// Throws an [ArgumentError] if a required argument is missing or has an invalid type.
  void _argumentValidation(String method, Map<dynamic, dynamic>? args,
      Map<String, Type> expectedArgs) {
    if (args == null) {
      throw ArgumentError("$method -> no arguments provided");
    }

    for (var entry in expectedArgs.entries) {
      final key = entry.key;
      final expectedType = entry.value;

      if (!args.containsKey(key)) {
        throw ArgumentError("$method -> Missing required argument: '$key'");
      }

      final value = args[key];
      if (value.runtimeType != expectedType) {
        throw ArgumentError(
            "$method -> Invalid type for argument '$key'. Expected: $expectedType, but got: ${value.runtimeType}");
      }
    }
  }
}

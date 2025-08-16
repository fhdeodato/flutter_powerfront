import 'package:flutter/widgets.dart';
import 'package:flutter_powerfront/flutter_powerfront.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_powerfront_method_channel.dart';

abstract class FlutterPowerfrontPlatform extends PlatformInterface {
  /// Constructs a FlutterPowerfrontPlatform.
  FlutterPowerfrontPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPowerfrontPlatform _instance = MethodChannelFlutterPowerfront();

  /// The default instance of [FlutterPowerfrontPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPowerfront].
  static FlutterPowerfrontPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPowerfrontPlatform] when
  /// they register themselves.
  static set instance(FlutterPowerfrontPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // ----- Power front methods -----

  Future<void> init(InsideInitConfiguration config) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Future<void> dismiss() {
    throw UnimplementedError('dismiss() has not been implemented.');
  }

    Future<void> detachChatPane() {
    throw UnimplementedError('detachChatPane() has not been implemented.');
  }

  Future<void> disconnect() {
    throw UnimplementedError('disconnect() has not been implemented.');
  }

  Future<bool?> setView() {
    throw UnimplementedError('setView() has not been implemented.');
  }
  
  Future<bool?> setUser() {
    throw UnimplementedError('setUser() has not been implemented.');
  }

  Future<bool?> setCart() {
    throw UnimplementedError('setCart() has not been implemented.');
  }

  Future<bool?> addItemToCart() {
    throw UnimplementedError('addItemToCart() has not been implemented.');
  }

  Future<bool?> updateItemToCart() {
    throw UnimplementedError('updateItemToCart() has not been implemented.');
  }

  Future<bool?> removeItemFromCart() {
    throw UnimplementedError('removeItemFromCart() has not been implemented.');
  }

  Future<bool?> clearCart() {
    throw UnimplementedError('clearCart() has not been implemented.');
  }

  Future<bool?> completeOrder() {
    throw UnimplementedError('completeOrder() has not been implemented.');
  }

  Future<bool?> abandonCart() {
    throw UnimplementedError('abandonCart() has not been implemented.');
  }

  Future<bool?> push() {
    throw UnimplementedError('push() has not been implemented.');
  }

  /// Push inside chat
  Future<void> pushView({int top = 0, int bottom = 0}) {
    throw UnimplementedError('pushView() has not been implemented.');
  }

  /// Present inside chat
  Future<void> presentView({int top = 0, int bottom = 0}) {
    throw UnimplementedError('presentView() has not been implemented.');
  }

  Future<int> getUnreadMessagesCount() {
    throw UnimplementedError('getUnreadMessagesCount() has not been implemented.');
  }
  
  Future<void> setLoaderBackgroundColor(String color) {
    throw UnimplementedError('setLoaderBackgroundColor() has not been implemented.');
  }

  Future<void> showHideDefaultLoader(bool isEnabled) {
    throw UnimplementedError('showHideDefaultLoader() has not been implemented.');
  }


  // ----- Powerfront events -----
    
  /// Triggered when the Inside establishes a connection.
  ///
  /// This method registers a callback that is invoked when the Inside platform
  /// successfully establishes a connection. Once connected, chat and other 
  /// real-time functionalities become available.
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [VoidCallback] that is executed 
  ///   when the connection is established.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnConnected(() {
  ///   print("Inside is now connected. Real-time functionality is available.");
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default, 
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void.
  void setOnConnected(VoidCallback callback) {
    throw UnimplementedError('setOnConnected() has not been implemented.');
  }


  /// Triggered when the chat availability is toggled.
  ///
  /// This method registers a callback that is invoked whenever the chat 
  /// availability changes. The callback receives a single boolean parameter:
  /// - `true`: Indicates that the chat is available.
  /// - `false`: Indicates that the chat is unavailable.
  ///
  /// ### Parameters:
  /// - [callback]: A function that accepts a [bool] parameter, `available`,
  ///   which represents the current chat availability.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnChatAvailable((available) {
  ///   if (available) {
  ///     print("Chat is now available.");
  ///   } else {
  ///     print("Chat is currently unavailable.");
  ///   }
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default, 
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnChatAvailable(Function(bool available) callback) {
    throw UnimplementedError('setOnChatAvailable() has not been implemented.');
  }

  /// Triggered when the chat is visible.
  ///
  /// This method registers a callback that is invoked when the chat is visible
  /// 
  /// from the documentation
  /// 
  /// The method will be called when chatpane is loaded properly into the view default loader 
  /// disappears as soon as this method gets called and you can wait until the view is available 
  /// and to hide custom loader once this method is invoked 
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [VoidCallback] that is executed 
  ///   when the chat is visible.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnChatVisible(() {
  ///   print("Chat is now visible");
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default, 
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void.
  void setOnChatVisible(VoidCallback callback) {
    throw UnimplementedError('setOnChatVisible() has not been implemented.');
  }

  /// Registers a callback that is invoked when a chat message is received while the chat pane is closed.
  ///
  /// This method allows you to provide a callback function that will be executed
  /// whenever a message is received in the chat while the chat pane is not visible.
  /// The callback provides detailed information about the message, such as the
  /// message text, whether it is a proactive chat, the sender's name, and the
  /// operator's image URL (if available).
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [ChatMessageCallback] that processes
  ///   the chat message details. The callback provides the following parameters:
  ///   - [messageText] (String): The text content of the chat message.
  ///   - [proactiveChat] (bool): `true` if the chat is proactive (initiated by the operator),
  ///     `false` if it is not.
  ///   - [senderName] (String): The name of the sender (e.g., the operator).
  ///   - [operatorImageUrl] (String?): The URL of the operator's image, a default operator image,
  ///     or a custom image URL as specified by the theme. This can be `null` if no image is specified.
  ///
  /// ### Example:
  /// ```dart
  /// await onChatMessage((messageText, proactiveChat, senderName, operatorImageUrl) {
  ///   print("Message received: $messageText");
  ///   print("Proactive Chat: $proactiveChat");
  ///   print("Sender: $senderName");
  ///   if (operatorImageUrl != null) {
  ///     print("Operator Image URL: $operatorImageUrl");
  ///   } else {
  ///     print("No operator image specified.");
  ///   }
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default,
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnChatMessage(ChatMessageCallback callback) {
    throw UnimplementedError('onChatMessage() has not been implemented.');
  }


  /// Registers a callback that is invoked when the user taps the "Add to Basket" button on a product card.
  ///
  /// This method allows you to provide a callback that handles the "Add to Basket" action for a product.
  /// The callback receives the product's ID and SKU, and it expects a response indicating whether the 
  /// product was added to the basket successfully or if the operation failed.
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [AddToBasketCallback] that processes the "Add to Basket" action. 
  ///   The callback provides the following parameters:
  ///   - [productId] (String): The unique identifier of the product being added to the basket.
  ///   - [skuId] (String): The SKU identifier of the product being added.
  ///   - [completionBlock] (Function(bool)): A block to be called after the operation completes:
  ///     - Pass `true` if the product was successfully added to the basket.
  ///     - Pass `false` if the operation failed.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnAddToBasket((productId, skuId, completionBlock) {
  ///   print("Attempting to add product to basket...");
  ///   print("Product ID: $productId");
  ///   print("SKU ID: $skuId");
  ///
  ///   // Simulate adding product to basket
  ///   bool success = true; // Replace with real logic
  ///   completionBlock(success);
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default,
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnAddToBasket(AddToBasketCallback callback) {
    throw UnimplementedError('setOnAddToBasket() has not been implemented.');
  }


  /// Registers a callback that is invoked when the user taps the "View Details" button on a product card.
  ///
  /// This method allows you to handle the "View Details" action for a specific product.
  /// The callback provides the product's ID and SKU, which can be used to display additional
  /// details about the product or navigate to a product details page.
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [ViewProductDetailsCallback] that processes the "View Details" action. 
  ///   The callback provides the following parameters:
  ///   - [productId] (String): The unique identifier of the product whose details are being requested.
  ///   - [skuId] (String): The SKU identifier of the product.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnViewProductDetails((productId, skuId) {
  ///   print("Viewing details for product:");
  ///   print("Product ID: $productId");
  ///   print("SKU ID: $skuId");
  ///
  ///   // Navigate to the product details page or perform another action
  ///   navigateToProductDetailsPage(productId, skuId);
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default,
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnViewProductDetails(ViewProductDetailsCallback callback) {
    throw UnimplementedError('setOnViewProductDetails() has not been implemented.');
  }

  /// Registers a callback that is invoked when the close button is tapped in the chat view.
  ///
  /// This method allows you to handle the close action when a user taps the close button 
  /// within the chat view. It can be used to perform any cleanup operations, navigate 
  /// the user to another screen, or log the event for analytics purposes.
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [VoidCallback] that is executed when the close button is tapped.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnChatClose(() {
  ///   print("Chat view has been closed.");
  ///
  ///   // Perform cleanup or navigation
  ///   closeChatView();
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default,
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - A [Future<void>] that completes when the callback is registered.
  void setOnChatClose(VoidCallback callback) {
    throw UnimplementedError('setOnChatClose() has not been implemented.');
  }

  /// Registers a callback that is invoked when the minimise button is tapped in the chat view.
  ///
  /// This method allows you to handle the minimise action when a user taps the minimise 
  /// button within the chat view. It can be used to update the UI, save the chat state, 
  /// or log the action for analytics purposes.
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [VoidCallback] that is executed when the minimise button is tapped.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnChatMinimise(() {
  ///   print("Chat view has been minimised.");
  ///
  ///   // Update the UI to reflect the minimised state
  ///   minimiseChatView();
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default,
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnChatMinimise(VoidCallback callback) {
    throw UnimplementedError('setOnChatMinimise() has not been implemented.');
  }

  /// Triggered when the client's real-time connection has disconnected.
  void setOnDisconnected(VoidCallback callback) {
    throw UnimplementedError('setOnDisconnected() has not been implemented.');
  }

  /// Registers a callback to be invoked when the chat has ended.
  ///
  /// Triggered when chat is ended by visitor or operator/system.
  ///
  /// ### Parameters:
  /// - [callback]: A function that will be invoked when the chat ends. 
  ///   The `endedBy` parameter is a [InsideEndedBy] that specifies who ended the chat.
  ///   Value is "visitor" when chat is ended by user, "operator" when chat is ended by operator or system.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnChatEnded((endedBy) {
  ///   print("Chat ended by: $endedBy");
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. 
  /// By default, it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  /// 
  void setOnChatEnded(Function(InsideEndedBy endedBy) callback) {
    throw UnimplementedError('setOnChatEnded() has not been implemented.');
  }

  /// Registers a callback to handle errors that occur during chat operations.
  ///
  /// This method allows you to define a callback function to handle errors.
  /// The callback is invoked whenever an error occurs, providing details
  /// about the error through the [ErrorCallback].
  ///
  /// ### Parameters:
  /// - [callback]: A function of type [ErrorCallback] that handles the error.
  ///
  /// ### Example:
  /// ```dart
  /// await setOnError((error) {
  ///   print("An error occurred: ${error.message}");
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default, 
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnError(ErrorCallback callback) {
    throw UnimplementedError('setOnError() has not been implemented.');
  }

  /// Registers a callback to handle link taps within the chat pane.
  ///
  /// This method allows you to define a callback that is triggered when
  /// a link within the chat pane is tapped. The callback receives the tapped
  /// link's URL as a [String]. It must return a [bool] indicating whether the
  /// app has handled the link:
  /// - Return `true` if the link was handled by the app.
  /// - Return `false` if the link was not handled and should be processed
  ///   by the default handler.
  ///
  /// ### Parameters:
  /// - [callback]: A function that takes a [String] URL and returns a [bool].
  ///
  /// ### Example:
  /// ```dart
  /// await setOnLinkTapped((url) {
  ///   if (url.startsWith("https://example.com")) {
  ///     print("Handling link internally: $url");
  ///     return true;
  ///   }
  ///   return false;
  /// });
  /// ```
  ///
  /// ### Note:
  /// This function must be implemented in the native code or plugin. By default, 
  /// it throws an [UnimplementedError].
  ///
  /// ### Errors:
  /// - Throws an [UnimplementedError] if the function is not implemented.
  ///
  /// ### Returns:
  /// - void
  void setOnLinkTapped(Function(String url) callback) {
    throw UnimplementedError('setOnLinkTapped() has not been implemented.');
  }

}

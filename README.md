# flutter_powerfront

Flutter plugin that connects the Powerfront SDKs

## Permission to be added

Add the following permissions to the info.plist

```
NSPhotoLibraryUsageDescription
NSCameraUsageDescription
NSMicrophoneUsageDescription
```

## Covered events

- onConnected
- onChatAvailable
- onChatMessage
- onChatClose
- onChatMinimise
- onChatEnded
- onDisconnected
- onError
- onLinkTapped

## Product Events

- onAddToBasket
- onViewProductDetails

## Tracking methods

MISSING IMPLEMENTATION

## PROPERTIES

MISSING IMPLEMENTATION
    getUnreadMessagesCount

## Setup

1 - Create the plugin intance

```
  final _flutterPowerfrontPlugin = FlutterPowerfront();
```

2 - Create a `InsideInitConfiguration` object 

```
InsideInitConfiguration initConfig = InsideInitConfiguration(
    domainURL: '',
    accountKey: '',
    appName: '',
    mobileSiteURL: '',
    subsiteId: '',
);
```

2 - Call the `init` method passing the configuration object

```
_flutterPowerfrontPlugin.init(initConfig);
```

3 - Attach the needed event listners to the object, this could be done before the `init` also

```
_flutterPowerfrontPlugin.onConnected(powerFrontOnConnected);
_flutterPowerfrontPlugin.onChatClose(powerFrontOnChatClose);
_flutterPowerfrontPlugin.onChatMinimise(powerFrontOnChatMinimise);
_flutterPowerfrontPlugin.onChatEnded(powerFrontOnChatEnded);
```

4 - To display the chat, call

```
_flutterPowerfrontPlugin.presentView();
```

This method will display the view with the chat inside ready to receive interaction from the customers

## Events examples

here is a list of the events and the need callback functions to handle each one

### onConnected
```dart
void powerFrontOnConnected() {
    debugLog("onConnected executed");
}
_flutterPowerfrontPlugin.onConnected(powerFrontOnConnected);
```

### onChatAvailable
```dart
void powerFrontonChatAvailable(bool available) {
    debugLog("onChatAvailable executed");
}
_flutterPowerfrontPlugin.onChatAvailable(powerFrontonChatAvailable);
```

### onChatMessage
```dart
void powerFrontOnChatMessage(String messageText, bool proactiveChat,
    String senderName, String? operatorImageUrl) {
    debugLog("powerFrontOnChatMessage executed, messageText -> ${messageText}");
}
_flutterPowerfrontPlugin.onChatMessage(powerFrontOnChatMessage);
```

### onChatClose
```dart
void powerFrontOnChatClose() {
    debugLog("onChatClose executed");
}
_flutterPowerfrontPlugin.onChatClose(powerFrontOnChatClose);
```

### onChatMinimise
```dart
void powerFrontOnChatMinimise() {
    debugLog("onChatMinimise executed");
}
_flutterPowerfrontPlugin.onChatMinimise(powerFrontOnChatMinimise);
```

### onChatEnded
```dart
void powerFrontOnChatEnded(InsideEndedBy endedBy) {
    debugLog("onChatEnded executed, endedBy -> ${endedBy.name.toLowerCase()}");
}
_flutterPowerfrontPlugin.onChatEnded(powerFrontOnChatEnded);
```

### onDisconnected
```dart
void powerFrontonDisconnected() {
debugLog("onDisconnected executed");
}
_flutterPowerfrontPlugin.onDisconnected(powerFrontonDisconnected);
```

### onError
```dart
void powerFrontOnError(String message, int statusCode) {
    debugLog("onError executed, message -> $message");
}
_flutterPowerfrontPlugin.onError(powerFrontOnError);
```

### onLinkTapped
```dart
void powerFrontOnLinkTapped(String url) {
    debugLog("onLinkTapped executed, url -> $url");
}
_flutterPowerfrontPlugin.onLinkTapped(powerFrontOnLinkTapped);
```
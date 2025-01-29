typedef ChatMessageCallback = void Function(
  String messageText,
  bool proactiveChat,
  String senderName,
  String? operatorImageUrl,
);

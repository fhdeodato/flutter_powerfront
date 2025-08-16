class ChatMessage {
  final String messageText;
  final bool proactiveChat;
  final String senderName;
  final String? operatorImageUrl;

  ChatMessage({
    required this.messageText,
    required this.proactiveChat,
    required this.senderName,
    this.operatorImageUrl,
  });

  factory ChatMessage.fromMap(Map<dynamic, dynamic> map) {
    return ChatMessage(
      messageText: map['messageText'] as String,
      proactiveChat: map['proactiveChat'] as bool,
      senderName: map['senderName'] as String,
      operatorImageUrl: map['operatorImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'messageText': messageText,
      'proactiveChat': proactiveChat,
      'senderName': senderName,
      'operatorImageUrl': operatorImageUrl,
    };
  }
} 
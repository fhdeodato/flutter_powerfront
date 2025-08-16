class InsideError {
  final String message;
  final int statusCode;

  InsideError({
    required this.message,
    required this.statusCode,
  });

  factory InsideError.fromMap(Map<dynamic, dynamic> map) {
    return InsideError(
      message: map['message'] as String,
      statusCode: map['statusCode'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'statusCode': statusCode,
    };
  }
} 
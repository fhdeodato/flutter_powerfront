class AddToBasketData {
  final String productId;
  final String skuId;

  AddToBasketData({
    required this.productId,
    required this.skuId,
  });

  factory AddToBasketData.fromMap(Map<dynamic, dynamic> map) {
    return AddToBasketData(
      productId: map['productId'] as String,
      skuId: map['skuId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'skuId': skuId,
    };
  }
} 
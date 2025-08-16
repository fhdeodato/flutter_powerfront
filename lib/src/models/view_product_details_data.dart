class ViewProductDetailsData {
  final String productId;
  final String? skuId;

  ViewProductDetailsData({
    required this.productId,
    this.skuId,
  });

  factory ViewProductDetailsData.fromMap(Map<dynamic, dynamic> map) {
    return ViewProductDetailsData(
      productId: map['productId'] as String,
      skuId: map['skuId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'skuId': skuId,
    };
  }
} 
import 'package:flutter/widgets.dart';

typedef AddToBasketCallback = void Function(
  String productId,
  String skuId,
  {
    VoidCallbackAction Function(bool)? callback,
  }
);
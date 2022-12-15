// @JS()
// library stripe;
//
// import 'package:flutter/material.dart';
// import 'package:js/js.dart';
//
// import '../constants.dart';
//
//
// void redirectToCheckout(BuildContext _) async {
//   final stripe = Stripe(apiKey);
//   stripe.redirectToCheckout(CheckoutOptions(
//     lineItems: [
//       LineItem(price: nikesPriceId, quantity: 1),
//     ],
//     mode: 'payment',
//     successUrl: 'http://localhost:54872/#/success',
//     cancelUrl: 'http://localhost:54872/#/cancel',
//   ));
// }
//
// // create stripe object with it's constructor
// @JS()
// class Stripe {
//   external Stripe(String key);
//
//   external redirectToCheckout(CheckoutOptions options);
// }
//
// // create checkOutOption class
//
// @JS()
// @anonymous
// class CheckoutOptions {
//   external List<LineItem> get lineItems;
//
//   external String get mode;
//
//   external String get successUrl;
//
//   external String get cancelUrl;
//
//   external factory CheckoutOptions({
//     List<LineItem> lineItems,
//     String mode,
//     String successUrl,
//     String cancelUrl,
//     String sessionId,
//   });
//
//
//
// }
//
// // create class LineItem for product item
//
// @JS()
// @anonymous
// class LineItem {
//   external String get price;
//
//   external int get quantity;
//
//   external factory LineItem({String price, int quantity});
// }

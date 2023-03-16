// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class PaymentController {
//   Map<String, dynamic>? paymentIntentData;
//
//   static init(){
//     // Stripe.publishableKey =
//     //     'pk_test_51LmGAVDDoPqHMuBqMW5HIuAddrReuAQAnH7cmRXLpABXMCuiIDSocy67bUQRabrgwlLYy4raumP4LZS53BWA3jzT00r7LAf3Hy';
//     // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
//     // Stripe.urlScheme = 'flutterstripe';
//
//     // await Stripe.instance.applySettings();
//   }
//
//   Future<void> makePayment(
//       {required String amount, required String currency}) async {
//     try {
//       paymentIntentData = await createPaymentIntent(amount, currency);
//       if (paymentIntentData != null) {
//         await Stripe.instance.initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//           merchantDisplayName: 'Prospects',
//           customerId: paymentIntentData!['customer'],
//           paymentIntentClientSecret: paymentIntentData!['client_secret'],
//           customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
//         ));
//         displayPaymentSheet();
//       }
//     } catch (e, s) {
//       print('exception:$e$s');
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//
//         paymentIntentClientSecret:
//             'pi_3Ln1zdDDoPqHMuBq11eMwvtc_secret_ypONcvUN1dVRukzarqtjr92mj',
//         style: ThemeMode.dark,
//         merchantDisplayName: 'Prospects',
//       ));
//       await Stripe.instance.presentPaymentSheet();
//       Get.snackbar('Payment', 'Payment Successful',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(10),
//           duration: const Duration(seconds: 2));
//     } on Exception catch (e) {
//       if (e is StripeException) {
//         print("Error from Stripe: ${e.error.localizedMessage}");
//       } else {
//         print("Unforeseen error: ${e}");
//       }
//     } catch (e) {
//       print("exception:$e");
//     }
//   }
//
//   //  Future<Map<String, dynamic>>
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//         'payment_method_types[]': 'card'
//       };
//       var response = await http.post(
//           Uri.parse('https://api.stripe.com/v1/payment_intents'),
//           body: body,
//           headers: {
//             'Authorization':
//                 'sk_test_51LmGAVDDoPqHMuBqzZGu4VyNaOocROdUx0LsTXaG14if9dZ4wjI0myIEpdrDeDwWml4kn74gCKEXVcGkfvqkoDk700ujTnUFms',
//             'Content-Type': 'application/x-www-form-urlencoded'
//           });
//       return jsonDecode(response.body);
//     } catch (err) {
//       print('err charging user: ${err.toString()}');
//     }
//   }
//
//   calculateAmount(String amount) {
//     final a = (int.parse(amount)) * 100;
//     return a.toString();
//   }
// }

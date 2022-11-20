//4VvEFwxSl4WeVExWW6fw7bG9jWhMri2jlN9A

//123456

import 'package:crazy_food/app/data/remote_data_source/payment_apis.dart';
import 'package:crazy_food/app/modules/checkout/view/checkout_view.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as gg;
import 'package:get/get.dart';

import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';
import 'package:myfatoorah_flutter/utils/MFCountry.dart';
import 'package:myfatoorah_flutter/utils/MFEnvironment.dart';
import 'dart:io' show Platform;


/*
TODO: The following API token key for testing only, so that when you go live
      don't forget to replace the following key with the live key provided
      by MyFatoorah.
*/

final String mAPIUrl = "https://api.myfatoorah.com";

final String mAPIKey = "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";
class MyFatora extends StatefulWidget {
  final double amount;
  MyFatora( this.amount);


  @override
  _PaymentMyFatoorahState createState() => _PaymentMyFatoorahState();
}

class _PaymentMyFatoorahState extends State<MyFatora> {
  String _response = '';
  String _loading = "Loading...";

  List<PaymentMethods> ? paymentMethods = [];
  List<bool> ?isSelected = [];
  int ?selectedPaymentMethodIndex = -1;

  bool ? visibilityObs = false;

  @override
  void initState() {
    super.initState();

    // MFSDK.init(mAPIUrl, mAPIKey);
   // MFSDK.init(mAPIKey, MFCountry.SAUDI_ARABIA, MFEnvironment.LIVE);
    MFSDK.init(mAPIKey, MFCountry.EGYPT, MFEnvironment.TEST);

    initiatePayment();
  }

  void initiatePayment() {
    var request = new MFInitiatePaymentRequest(
        widget.amount, MFCurrencyISO.SAUDI_ARABIA_SAR);

    MFSDK.initiatePayment(
        request,
        MFAPILanguage.EN,
            (MFResult<MFInitiatePaymentResponse> result) => {
          if (result.isSuccess())
            {
              setState(() {
                  print('mm  =>'+(result.response?.toJson()).toString());
                _response = ""; //result.response.toJson().toString();
                paymentMethods?.addAll(result.response?.paymentMethods??[]);
                for (int i = 0; i < paymentMethods!.length; i++)
                  isSelected?.add(false);
              })
            }
          else
            {
              setState(() {
                print(result.error?.toJson());
                _response = result.error?.message??'';
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  /*
    Execute Regular Payment
   */
  void executeRegularPayment(int paymentMethodId) async{
    var request = new MFExecutePaymentRequest(paymentMethodId, widget.amount);

    MFSDK.executePayment(
        context,
        request,
        // context.locale.languageCode == "en"
        //     ? MFAPILanguage.AR
             MFAPILanguage.AR,
        onInvoiceCreated: (String invoiceId) =>
        {print("invoiceId: " + invoiceId)},
        onPaymentResponse: (String invoiceId,
            MFResult<MFPaymentStatusResponse> result) =>
        {
          if (result.isSuccess())
            {
              setState(() async {
                print(invoiceId + " <<<<<<<=-=--=-=-=-=-=-=invoiceId ");
                print((result.response?.invoiceTransactions?[0].paymentGateway).toString() + " <<<<<<<=-=--=-=-=-=-=-=invoiceId ");
                print((result.response?.invoiceTransactions?[0].cardNumber).toString() + " <<<<<<<=-=--=-=-=-=-=-=invoiceId ");
               //To Do firebase add payment


                // print(invoiceId + " <<<<<<<=-=--=-=-=-=-=-= trans from pay ${} ");
                print(result.response?.toJson());
                Navigator.pop(context, {
                  "type": "visa",
                  "transaction": invoiceId.toString(),
                  // result.response.invoiceTransactions[0].transactionId,
                });
              await PaymentApis().puplishPaymentMethod((result.response?.invoiceTransactions?[0].paymentGateway).toString(),
                   (result.response?.invoiceTransactions?[0].cardNumber).toString());
                _response = (result.response?.toJson()).toString();
              })
            }
          else
            {
              setState(() {
                print(invoiceId);
                print(
                    invoiceId.toString() + "-=-=-=-==--=-=-=-==-invoiceId");

                print((result.error?.toJson()).toString() +
                    "-=-=-=-==--=-=-=-==-error");

                _response = result.error?.message??'';
                /// you can use toast or snackbar
                // FlashHelper.errorBar(context,
                //     message: result.error.message);
              })
            }
        });

    setState(() {
      _response = _loading;
    });
  }

  void setPaymentMethodSelected(int index, bool value) {
    for (int i = 0; i < isSelected!.length; i++) {
      if (i == index) {
        isSelected?[i] = value;
        if (value) {
          selectedPaymentMethodIndex = index;
          visibilityObs = paymentMethods?[index].isDirectPayment;
        } else {
          selectedPaymentMethodIndex = -1;
          visibilityObs = false;
        }
      } else
        isSelected?[i] = false;
    }
  }

  void pay() {
    if (selectedPaymentMethodIndex == -1) {
      Fluttertoast.showToast(
          msg: "Please select payment method first",
          toastLength: Toast.LENGTH_SHORT,
        //  backgroundColor: backgroundColor,
         // textColor: textColor,
         // fontSize: textSize.small
      );


      // Toast.show("Please select payment method first", context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
    } else {
      executeRegularPayment(
          paymentMethods?[selectedPaymentMethodIndex??0].paymentMethodId??0);
    }
  }

  @override
  Widget build(BuildContext context) {
    //double widthC = MediaQuery.of(context).size.width;
    // AppBar appBar = AppBar(
    //   backgroundColor: kAccentColor,
    //   brightness: Brightness.light,
    //   elevation: 0,
    //   leading:  IconButton(
    //     onPressed:(){},
    //     icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
    //   ),
    //   title: Text(
    //    ('charge_wallet'),
    //     style: TextStyle(),
    //   ),
    //   centerTitle: true,
    // );
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // appBar: appBar,
        floatingActionButton:
          AppProgressButton(
            text: 'pay'.tr,
              width: 160,
              height: 50,
              radius: 10,
            fontSize: 20,
            backgroundColor: kPrimaryColor,
        child: AppText('pay'.tr,color: Colors.white,),
        onPressed: (AnimationController animationController) async{
              await  animationController.forward();
              await Future.delayed(Duration(seconds: 2));
              pay();
              await  animationController.reverse();
        }

          ),
      body: SafeArea(
        child: Container(
          decoration: kContainerDecoraction,
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height,
          child: Column(children: [
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed:()=>Get.to(()=>CheckoutView()),
                  icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                ),
                AppText('checkout'.tr,color: Colors.white,fontSize: 18,),
                SizedBox()
              ],
            ),
            SizedBox(
              height: 10,
            ),
                    Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20),bottom:  Radius.circular(20)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 18.0),
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.0,
                              mainAxisSpacing: 0.0),
                          itemCount: paymentMethods!.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            return Column(
                              children: <Widget>[
                                Image.network(paymentMethods?[index].imageUrl??'',
                                    width: 80.0, height: 60.0),
                                AppText(paymentMethods?[index].paymentMethodAr??'',fontSize: 20,),
                                Checkbox(
                                    value: isSelected?[index],
                                    onChanged: (bool ?value) {
                                      setState(() {
                                        setPaymentMethodSelected(index, value??true);
                                      });
                                    })
                              ],
                            );
                          }),
                    )),
   ] ),
        )));
  }
}

//
// class MyFatora extends StatefulWidget {
//   MyFatora(this.value);
//   String ? value;
//
// //  MyFatora({Key? key, required this.title}) : super(key: key);
//
//  // final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyFatora> {
//   String _response = '';
//   String _loading = "Loading...";
//   var sessionIdValue = "";
  late MFPaymentCardView mfPaymentCardView;
//   late MFApplePayButton mfApplePayButton;
//   bool isLoading=true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (mAPIKey.isEmpty) {
//       setState(() {
//         _response =
//         "Missing API Token Key.. You can get it from here: https://myfatoorah.readme.io/docs/test-token";
//       });
//       return;
//     }
//
//     // TODO, don't forget to init the MyFatoorah Plugin with the following line
//     MFSDK.init(mAPIKey, MFCountry.KUWAIT, MFEnvironment.TEST);
//     initiateSession();
//     // (Optional) un comment the following lines if you want to set up properties of AppBar.
//
// //    MFSDK.setUpAppBar(
// //      title: "MyFatoorah Payment",
// //      titleColor: Colors.white,  // Color(0xFFFFFFFF)
// //      backgroundColor: Colors.lightBlue, // Color(0xFF000000)
// //      isShowAppBar: true); // For Android platform only
//
//     // (Optional) un comment this line, if you want to hide the AppBar.
//     // Note, if the platform is iOS, this line will not affected
//
//     MFSDK.setUpAppBar(isShowAppBar: false);
//   }
//
//   void initiateSession() {
//     /**
//      * If you want to use saved card option with embedded payment, send the parameter
//      * "customerIdentifier" with a unique value for each customer. This value cannot be used
//      * for more than one Customer.
//      */
//     // var request = MFInitiateSessionRequest("12332212");
//
//     /**
//      * If not, then send null like this.
//      */
//     MFSDK.initiateSession(
//         null,
//             (MFResult<MFInitiateSessionResponse> result) => {
//           if (result.isSuccess())
//             {
//
//               // This for embedded payment view
//               mfPaymentCardView.load(result.response!)
//
//               /// This used for Apple Pay in iOS only.
//               // loadApplePay(result.response!)
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " +
//                     result.error!.toJson().toString().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//   }
//
//   void payWithEmbeddedPayment() {
//     var request = MFExecutePaymentRequest.constructor(0.100);
//     mfPaymentCardView.pay(
//         request,
//         MFAPILanguage.EN,
//             (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Error: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//   }
//
//   /// This used for Apple Pay in iOS only.
//   void loadApplePay(MFInitiateSessionResponse mfInitiateSessionResponse) {
//     var request = MFExecutePaymentRequest.constructorForApplyPay(
//         0.100, MFCurrencyISO.KUWAIT_KWD);
//     mfApplePayButton.load(
//         mfInitiateSessionResponse,
//         request,
//         MFAPILanguage.EN,
//             (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Error: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//   }
//
//   /*
//     Send Payment
//    */
//   void sendPayment() {
//     var request = MFSendPaymentRequest(
//         invoiceValue: 0.100,
//         customerName: "Customer name",
//         notificationOption: MFNotificationOption.LINK);
//
//     MFSDK.sendPayment(
//         context,
//         MFAPILanguage.EN,
//         request,
//             (MFResult<MFSendPaymentResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("Response: " +
//                     result.response!.toJson().toString().toString());
//                 _response = result.response!.toJson().toString().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " +
//                     result.error!.toJson().toString().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Initiate Payment
//    */
//   void initiatePayment() {
//     var request = new MFInitiatePaymentRequest(5.5, MFCurrencyISO.KUWAIT_KWD);
//
//     MFSDK.initiatePayment(
//         request,
//         MFAPILanguage.EN,
//             (MFResult<MFInitiatePaymentResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Execute Regular Payment
//    */
//   void executeRegularPayment() {
//     // The value 1 is the paymentMethodId of KNET payment method.
//     // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
//     int paymentMethod = 1;
//
//     var request = new MFExecutePaymentRequest(paymentMethod, 0.100);
//
//     MFSDK.executePayment(context, request, MFAPILanguage.EN,
//         onInvoiceCreated: (String invoiceId) =>
//         {print("invoiceId: " + invoiceId)},
//         onPaymentResponse: (String invoiceId,
//             MFResult<MFPaymentStatusResponse> result) =>
//         {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Execute Direct Payment
//    */
//   void executeDirectPayment() {
//     // The value 9 is the paymentMethodId of Visa/Master payment method.
//     // You should call the "initiatePayment" API to can get this id and the
//     // ids of all other payment methods
//     int paymentMethod = 9;
//
//     var request = new MFExecutePaymentRequest(paymentMethod, 0.100);
//
// //    var mfCardInfo = new MFCardInfo(cardToken: "Put your API token key here");
//
//     var mfCardInfo = new MFCardInfo(
//         cardNumber: "5453010000095489",
//         expiryMonth: "05",
//         expiryYear: "21",
//         securityCode: "100",
//         cardHolderName: "Set Name",
//         bypass3DS: false,
//         saveToken: false);
//
//     MFSDK.executeDirectPayment(
//         context,
//         request,
//         mfCardInfo,
//         MFAPILanguage.EN,
//             (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("invoiceId: " + invoiceId);
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Execute Direct Payment with Recurring
//    */
//   void executeDirectPaymentWithRecurring() {
//     // The value 20 is the paymentMethodId of Visa/Master payment method.
//     // You should call the "initiatePayment" API to can get this id and the ids
//     // of all other payment methods
//     int paymentMethod = 20;
//
//     var request = new MFExecutePaymentRequest(paymentMethod, 100.0);
//
//     var mfCardInfo = new MFCardInfo(
//         cardNumber: "5453010000095539",
//         expiryMonth: "05",
//         expiryYear: "21",
//         securityCode: "100",
//         cardHolderName: "Set Name",
//         bypass3DS: true,
//         saveToken: true);
//
//     mfCardInfo.iteration = 12;
//
//     MFSDK.executeRecurringDirectPayment(
//         context,
//         request,
//         mfCardInfo,
//         MFRecurringType.monthly,
//         MFAPILanguage.EN,
//             (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("Response: " + invoiceId);
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " + invoiceId);
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Payment Enquiry
//    */
//   void getPaymentStatus() {
//     var request = MFPaymentStatusRequest(invoiceId: "1209756"); // 1209773
//
//     MFSDK.getPaymentStatus(
//         MFAPILanguage.EN,
//         request,
//             (MFResult<MFPaymentStatusResponse> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("Response: " + result.response!.toJson().toString());
//                 _response = result.response!.toJson().toString().toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Cancel Token
//    */
//   void cancelToken() {
//     MFSDK.cancelToken(
//         "Put your token here",
//         MFAPILanguage.EN,
//             (MFResult<bool> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("Response: " + result.response.toString());
//                 _response = result.response.toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   /*
//     Cancel Recurring Payment
//    */
//   void cancelRecurringPayment() {
//     MFSDK.cancelRecurringPayment(
//         "Put RecurringId here",
//         MFAPILanguage.EN,
//             (MFResult<bool> result) => {
//           if (result.isSuccess())
//             {
//               setState(() {
//                 print("Response: " + result.response.toString());
//                 _response = result.response.toString();
//               })
//             }
//           else
//             {
//               setState(() {
//                 print("Response: " + result.error!.toJson().toString());
//                 _response = result.error!.message!;
//               })
//             }
//         });
//
//     setState(() {
//       _response = _loading;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double widthC = globalSize.setWidthPercentage(100, context);
//     double heightC = globalSize.setHeightPercentage(100, context);
//     AppBar appBar = AppBar(
//       backgroundColor: Colors.pink,
//       brightness: Brightness.light,
//       elevation: 0,
//       leading: ArrowIconButtonWidget(
//         iconColor: globalColor.black,
//       ),
//       title: Text(
//         Translations.of(context).translate('charge_wallet'),
//         style: textStyle.middleTSBasic.copyWith(color: globalColor.black),
//       ),
//       centerTitle: true,
//     );
//     return Scaffold(
//       appBar: appBar,
//       body: SafeArea(
//         child:
//         Container(
//           color: Colors.white,
//           width: widthC,
//           height: heightC,
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               Container(
//                 width: widthC,
//                 //height: 60,
//                 padding: EdgeInsets.all(12),
//                 margin: EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   border: Border.all(width: 1),
//                   borderRadius: BorderRadius.circular(7)
//                 ),
//
//                 child:Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: ()=>
//                         Get.Get.to(()=>ChargeWalletPage())
//                       ,),
//                     SizedBox(),
//                     Divider(height: 40,thickness:5,color: Colors.red,),
//                     Text('${widget.value}   ${Translations.of(context).translate('rail')}'),
//                     Icon(Icons.payments),
//
//
//                   ],
//                 )
//
//               ),
//           Expanded(
//             child: Container(
//               width: widthC,
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                   border: Border.all(width: 1),
//                   borderRadius: BorderRadius.circular(7)
//               ),
//                child:
//               createPaymentCardView(heightC),
//             ),
//           )
//
//             ],
//           ),
//         )
// //         child: Column(children: [
// //           SingleChildScrollView(
// //             child: Column(
// // //                    mainAxisAlignment: MainAxisAlignment.center,
// // //                    crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //
// //                 createPaymentCardView(),
// //
// //                 if (Platform.isIOS) createApplePayView(),
// //                 // RaisedButton(
// //                 //   child: Text('Pay (Embedded Payment)'),
// //                 //   onPressed: payWithEmbeddedPayment,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Send Payment'),
// //                 //   onPressed: sendPayment,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Initiate Payment'),
// //                 //   onPressed: initiatePayment,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Execute Regular Payment'),
// //                 //   onPressed: executeRegularPayment,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Execute Direct Payment'),
// //                 //   onPressed: executeDirectPayment,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Execute Direct Payment with Recurring'),
// //                 //   onPressed: executeDirectPaymentWithRecurring,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Cancel Recurring Payment'),
// //                 //   onPressed: cancelRecurringPayment,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Cancel Token'),
// //                 //   onPressed: cancelToken,
// //                 // ),
// //                 // RaisedButton(
// //                 //   child: Text('Get Payment Status'),
// //                 //   onPressed: getPaymentStatus,
// //                 // ),
// //                 // Padding(
// //                 //   padding: const EdgeInsets.all(5.0),
// //                 //   child: Text(_response),
// //                 // )
// //               ],
// //             ),
// //           ),
// //         ]),
//       ),
//     );
//   }
//
  createPaymentCardView(double height) {
    mfPaymentCardView = MFPaymentCardView(
      language: MFAPILanguage.AR,
      inputColor: Colors.red,
      labelColor: Colors.blue,
      errorColor: Colors.blue,
      borderColor: Colors.green,
      fontSize: 18,
      borderWidth: 1,
      borderRadius: 2,
      cardHeight: 270,
      // cardHolderNameHint: "card holder name hint",
      // cardNumberHint: "card number hint",
      // expiryDateHint: "expiry date hint",
      cvvHint: "cvv hint",
      showLabels: true,
      // cardHolderNameLabel: "card holder name label",
      // cardNumberLabel: "card number label",
      // expiryDateLabel: "expiry date label",
      // cvvLabel: "cvv label",
    );

    return mfPaymentCardView;
  }
//
//   /// This for Apple pay button
//   createApplePayView() {
//     mfApplePayButton = MFApplePayButton();
//     return mfApplePayButton;
//   }
// }
import 'package:crazy_food/app/data/remote_data_source/add_address_api.dart';
import 'package:crazy_food/app/modules/checkout/view/checkout_view.dart';
import 'package:crazy_food/app/shared/app_buttons/app_progress_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:get/get.dart';

class BottomAddAdress extends StatefulWidget {
  bool _show;
  Address? _address;
  String? currentLocationText;
  double? currentLatitude;
  double? chooseLongitude;
  double? chooseLatitude;
  double? currentLongitude;

  BottomAddAdress(
      this._show,
      this._address,
      this.currentLocationText,
      this.currentLatitude,
      this.currentLongitude,
      this.chooseLatitude,
      this.chooseLongitude);

  @override
  State<BottomAddAdress> createState() => _BottomAddAdressState();
}

class _BottomAddAdressState extends State<BottomAddAdress> {
  bool? isCurrentSelected = false;
  bool? isChooseSelected = false;
  String ? finalAddress;
  double ? finalLatitude;
  double ? finalLongitude;

  @override
  Widget build(BuildContext context) {
    if (widget._show) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AppText(
                      'current_location'.tr,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 170,
                      child: AppText(
                        widget.currentLocationText ?? '',
                        color: kPrimaryColor,
                        textOverflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
                Checkbox(
                  value: isCurrentSelected,
                  onChanged: (val) {
                    setState(() {
                      isCurrentSelected = true;
                      isChooseSelected = false;
                    });
                  },
                ),
              ],
            ),
            Visibility(
              visible:
                  (widget._address?.addressLine ?? null) == null ? false : true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppText(
                        'selected_location'.tr,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      SizedBox(
                          width: 170,
                          child: AppText(
                            (widget._address?.addressLine ?? null).toString(),
                            color: kPrimaryColor,
                            textOverflow: TextOverflow.clip,
                          ))
                    ],
                  ),
                  Checkbox(
                      value: isChooseSelected,
                      onChanged: (val) {
                        setState(() {
                          isCurrentSelected = false;
                          isChooseSelected = true;
                        });
                      }),
                ],
              ),
            ),
            AppProgressButton(
              onPressed: (animationController) async {
                animationController.forward();
                await Future.delayed(Duration(seconds: 2));
                if(isChooseSelected!){
                  finalAddress=(widget._address?.addressLine).toString();
                  finalLatitude=widget.chooseLatitude;
                  finalLongitude=widget.chooseLongitude;
                }else{
                  finalAddress=widget.currentLocationText;
                  finalLatitude=widget.currentLatitude;
                  finalLongitude=widget.currentLongitude;
                }
                AddAddressApis()
                    .addAddress(finalAddress ?? '', finalLatitude ?? 0.0,
                        finalLongitude ?? 0.0)
                    .then((value) => Get.offAll(() => CheckoutView(), ));
                widget._show = false;
                setState(() {});
              },
              text: ("add_address".tr),
              textColor: Colors.white,
              backgroundColor: kPrimaryColor,
              height: 40,
            )
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }
}

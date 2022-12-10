import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class PaymentWidget extends GetView<CheckoutController>{
  PaymentModel ? model;
  int index;
  bool isSelected;
  PaymentWidget(this.model,this.index,this.isSelected, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext contextt) {
  return GetBuilder<CheckoutController>(
    builder: (context) {
      return InkWell(
        onTap: (){
        Get.log('bbb  $isSelected');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(value:isSelected? true:false,
                checkColor: Colors.white,
                activeColor: kPrimaryColor,
                onChanged: (val){
              controller.setPaymentIndex(index);
               controller.changePaymentTypeSelected(index, val);
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                AppText(model?.type??''),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.asset('assets/icon/visa.svg',width: 60,height: 25,),
                    const SizedBox(width: 15,),
                    AppText((model?.id).toString(),color: Colors.blue,),
                  ],
                )

              ],
            )
          ],
        ),
      );
    }
  );
  }



  buildCircle(){
   return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kAccentColor.withOpacity(0.4)
      ),
    );
  }

}
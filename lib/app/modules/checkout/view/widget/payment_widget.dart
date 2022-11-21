import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class PaymentWidget extends GetView<CheckoutController>{
  PaymentModel ? model;
  int index;
  bool isSelected;
  PaymentWidget(this.model,this.index,this.isSelected);
  @override
  Widget build(BuildContext context) {
  return GetBuilder<CheckoutController>(
    builder: (context) {
      return InkWell(
        onTap: (){
  Get.log('bbb  '+isSelected.toString());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(value:isSelected? true:false,
                checkColor: Colors.white,
                activeColor: kPrimaryColor,
                onChanged: (val){
              controller.setPaymentIndex(index);
              // isSelected?controller.paymentTypeSelected![index]=true:
              // controller.paymentTypeSelected![index]=false;
               controller.changePaymentTypeSelected(index, val);
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                AppText(model?.type??''),
                SizedBox(height: 5,),
                Row(
                  children: [
                    SvgPicture.asset('assets/icon/visa.svg',width: 60,height: 25,),
                    SizedBox(width: 15,),
                    AppText((model?.id).toString()??'',color: Colors.blue,),
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

}
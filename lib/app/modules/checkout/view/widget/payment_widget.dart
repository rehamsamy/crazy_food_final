import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
class PaymentWidget extends GetView<CheckoutController>{
  PaymentModel ? model;
  PaymentWidget(this.model);
  @override
  Widget build(BuildContext context) {
    //model?.id='123456777777555';
    String cardId=(((model?.id).toString()).replaceRange(0, 11, '*'));
    String id=(model?.id).toString();
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Checkbox(value: true, onChanged: (val){}),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(model?.type??''),
          Row(
            children: [
       SvgPicture.asset('assets/icon/visa.svg',width: 50,height: 25,),
              SizedBox(width: 10,),
              AppText('${cardId}${id.substring(12,15)}'??'',color: Colors.grey,),
            ],
          )

        ],
      )
    ],
  );
  }

}
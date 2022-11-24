import 'package:crazy_food/app/data/models/payment_model.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
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
  Widget build(BuildContext contextt) {
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
              // _showDialog(contextt);
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


  void _showDialog(BuildContext context) {
    Get.log('alerttt');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCircle(),
                  SizedBox(width: 2,),
                  buildCircle(),
                  SizedBox(width: 2,),
                  buildCircle()
                ],),
              SizedBox(height: 20,),
              Image.asset('assets/images/shopping-cart.png'),
              AppText('order_success'.tr,fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold,),
              SizedBox(height: 8,),
              AppText('order_success_data'.tr,fontSize: 15,color: Colors.grey,),
              SizedBox(height: 20,),
              AppElevatedButton(text: 'track_my_order'.tr, onPressed: (){

                ////   add order to firebase ///////

              },backgroundColor: kPrimaryColor,
              textColor: Colors.white,),
              SizedBox(height: 20,),
              InkWell(child: AppText('go_back'.tr,color: kPrimaryColor,),
              onTap: (){
                Navigator.of(context).pop();
                Get.offAll(()=>HomeScreenView());
              },)
            ],
          ),
        );
      },
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
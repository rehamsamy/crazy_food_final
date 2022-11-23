import 'package:crazy_food/app/data/models/address_model.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/modules/home/view/home_screen.dart';
import 'package:crazy_food/app/shared/app_buttons/app_elevated_button.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
class AddressWidget extends GetView<CheckoutController>{
  Address ? model;
  int index;
  bool isSelected;
  AddressWidget(this.model,this.index,this.isSelected);
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
              controller.setAddressIndex(index);
              _showDialog(contextt);
               controller.changeAddressTypeSelected(index, val);
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                AppText('address'.tr,fontWeight: FontWeight.bold,fontSize: 17,),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,color: kPrimaryColor,),
                    SizedBox(width: 10,),
                    SizedBox(width:Get.width-120,child: AppText((model?.addressTitle).toString(),color: Colors.blue,)),
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
import 'package:crazy_food/app/data/models/address_model.dart';
import 'package:crazy_food/app/modules/checkout/controller/checkout_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class AddressWidget extends GetView<CheckoutController>{
  Address ? model;
  int index;
  bool isSelected;
  AddressWidget(this.model,this.index,this.isSelected, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext contextt) {
  return GetBuilder<CheckoutController>(
    builder: (context) {
      return InkWell(
        onTap: (){
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(value:isSelected? true:false,
                checkColor: Colors.white,
                activeColor: kPrimaryColor,
                onChanged: (val){
              controller.setAddressIndex(index);
              // _showDialog(contextt);
               controller.changeAddressTypeSelected(index, val);
            }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                AppText('address'.tr,fontWeight: FontWeight.bold,fontSize: 15,
               ),
                const SizedBox(height: 5,),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,color: kPrimaryColor,),
                    const SizedBox(width: 10,),
                    SizedBox(width:Get.width-140,child: AppText((model?.addressTitle).toString(),color: Colors.blue,
                    maxLines: 2,)),
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
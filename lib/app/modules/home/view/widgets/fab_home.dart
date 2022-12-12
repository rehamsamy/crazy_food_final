import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/modules/cart/controller/cart_controller.dart';
import 'package:crazy_food/app/modules/cart/view/cart_view.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class FabHome extends StatelessWidget{
  CartController cartController=Get.find();
   FabHome({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return  GetBuilder<CartController>(
     init:cartController ,
     builder: (_) {
       return GestureDetector(
         onTap: (){
           Get.offAll(()=>CartScreen(fabFlag:'yes'),binding: GetBinding());
         },
         // =>Get.offAll(()=>CartScreen(fabFlag:'yes'),binding: GetBinding()),
         child: Container(
           decoration: const BoxDecoration(
             color: kPrimaryColor,
             shape: BoxShape.circle,
           ),
           child: Padding(
             padding: const EdgeInsets.all(10.0),
             child: Card(
               elevation: 10,
               color: Colors.white,
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(50),
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Badge(
                   toAnimate: true,
                   badgeContent:AppText('${cartController.cartCount}',color: Colors.white,),
                   position:BadgePosition.topEnd(top:-15),
                   child: const Icon(
                     Icons.shopping_cart_outlined,
                     color: kPrimaryColor,
                   ),
                 ),
               ),
             ),
           ),
         ),
       );
     }
   );
  }

}
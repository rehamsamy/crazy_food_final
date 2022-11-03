import 'package:crazy_food/app/modules/cart/view/cart_view.dart';
import 'package:crazy_food/app/modules/category_items_screen/controller/category_items_controller.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';

class FabHome extends GetView<CategoryItemsController>{
  @override
  Widget build(BuildContext context) {
   return  GetBuilder<CategoryItemsController>(
     builder: (context) {
       return GestureDetector(
         onTap: ()=>Get.to(()=>CartScreen(fabFlag:'yes')),
         child: Container(
           decoration: BoxDecoration(
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
                   badgeContent:AppText('${controller.cartCount}',color: Colors.white,),
                   position:BadgePosition.topEnd(top:-15),
                   child: Icon(
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
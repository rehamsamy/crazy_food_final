import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

class FabHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Container(
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
             badgeContent:AppText('3',color: Colors.white,),
             position:BadgePosition.topEnd(top:-15),
             child: Icon(
               Icons.shopping_cart_outlined,
               color: kPrimaryColor,
             ),
           ),
         ),
       ),
     ),
   );
  }

}
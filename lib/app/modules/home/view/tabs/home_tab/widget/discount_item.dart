import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:crazy_food/app/shared/app_text.dart';
import 'package:crazy_food/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountItem extends StatelessWidget {

  static double height=150;
  ProductModel model;
  int index;
  DiscountItem(this.index,this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: colorsMenu[index%6]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 15,),
          AppCashedImage(
            radius: 12,
            imageUrl: model.imagePath?? 'https://img.freepik.com/free-photo/top-view-condiments-aromatic-herbs_1220-435.jpg?t=st=1649609286~exp=1649609886~hmac=29ddbc5648f242fd0af6ec09e2ac4c6ebade2615cbad24c4a32b1ab607c8da59&w=1060',
            width: MediaQuery.of(context).size.width * 0.30,
            height: 120,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText('${model.discount} % DISCOUNT',color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 20,),
              SizedBox(height: 10,),
              SizedBox(width:150,child: AppText('order_message'.tr,fontSize: 15,maxLines: 2,textOverflow: TextOverflow.ellipsis,)),
              SizedBox(height: 20,),
              InkWell(child:AppText('order_now'.tr,color: kPrimaryColor,fontSize: 14,fontWeight: FontWeight.bold),onTap: (){},)
            ],
          )
        ],
      ),
    );
  }


}

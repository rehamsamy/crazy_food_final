import 'package:crazy_food/app/core/get_binding.dart';
import 'package:crazy_food/app/data/models/category_items_model.dart';
import 'package:crazy_food/app/modules/product_details/view/product_details_screen.dart';
import 'package:crazy_food/app/shared/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularItem extends StatelessWidget {

  ProductModel model;
  List<ProductModel> ?allProducts;
  List<ProductModel> ?similarProducts=[];
  PopularItem(this.model,this.allProducts);

  @override
  Widget build(BuildContext context) {
     return  InkWell(
       onTap: (){
         similarProducts?.map((e) {
           if(e.idType==model.id){
             similarProducts?.add(e);
           }
         } ).toList();
         Get.to(()=>ProductDetailsScreen(),binding: GetBinding(),
             arguments: {'product_details':model,
               'similarProducts':similarProducts});
       },
       child: Padding(
         padding: const EdgeInsets.all(5.0),
         child: AppCashedImage(
           radius: 15,
           height: 130,
           width: 140,
           fit: BoxFit.cover,
           imageUrl:model.imagePath?? 'https://cdn.britannica.com/27/218927-050-E99E1D46/Lychee-fruit-tree-plant.jpg',
         ),
       ),
     );
  }
}
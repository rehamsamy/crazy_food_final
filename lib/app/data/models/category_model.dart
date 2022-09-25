
class CategoryModel {
  CategoryModel({
    this.categories,});

  CategoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['categories'] !=null) {
      categories = [];
      json['categories'] .forEach((v) {
        categories?.add(CategoryItemModel.fromJson(v));
      });
    }
  }
  bool? status;
  List<CategoryItemModel>? categories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class CategoryItemModel {
  CategoryItemModel({
      this.id,
      this.typeId,
      this.name, 
      this.imagePath, 
      this.type,});

  CategoryItemModel.fromJson(dynamic json) {
    id = json['id'];
    typeId = json['type_id'];
    name = json['name'];
    imagePath = json['image_path'];
    type = json['type'];
  }
  int? id;
  int? typeId;
  String? name;
  String? imagePath;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type_id'] = typeId;
    map['name'] = name;
    map['image_path'] = imagePath;
    map['type'] = type;
    return map;
  }

}
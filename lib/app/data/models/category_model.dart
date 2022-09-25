/// id : 1
/// idType : 1
/// imagePath : "https://toppng.com/uploads/preview/fast-food-11549470764zfdstlnivq.png"
/// nameAr : "برجر"
/// nameEn : "Burger"
/// type : ""

class CategoryItemModel {
  CategoryItemModel({
      num? id, 
      num? idType, 
      String? imagePath, 
      String? nameAr, 
      String? nameEn, 
      String? type,}){
    _id = id;
    _idType = idType;
    _imagePath = imagePath;
    _nameAr = nameAr;
    _nameEn = nameEn;
    _type = type;
}

  CategoryItemModel.fromJson(dynamic json) {
    _id = json['id'];
    _idType = json['idType'];
    _imagePath = json['imagePath'];
    _nameAr = json['nameAr'];
    _nameEn = json['nameEn'];
    _type = json['type'];
  }
  num? _id;
  num? _idType;
  String? _imagePath;
  String? _nameAr;
  String? _nameEn;
  String? _type;
  CategoryItemModel copyWith({  num? id,
  num? idType,
  String? imagePath,
  String? nameAr,
  String? nameEn,
  String? type,
}) => CategoryItemModel(  id: id ?? _id,
  idType: idType ?? _idType,
  imagePath: imagePath ?? _imagePath,
  nameAr: nameAr ?? _nameAr,
  nameEn: nameEn ?? _nameEn,
  type: type ?? _type,
);
  num? get id => _id;
  num? get idType => _idType;
  String? get imagePath => _imagePath;
  String? get nameAr => _nameAr;
  String? get nameEn => _nameEn;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['idType'] = _idType;
    map['imagePath'] = _imagePath;
    map['nameAr'] = _nameAr;
    map['nameEn'] = _nameEn;
    map['type'] = _type;
    return map;
  }

}
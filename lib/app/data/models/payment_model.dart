/// id : 1145793211566
/// type : "visa/master"

class PaymentModel {
  PaymentModel({
      num? id, 
      String? type,}){
    _id = id;
    _type = type;
}

  PaymentModel.fromJson(dynamic json) {
    _id = json['id'];
    _type = json['type'];
  }
  num? _id;
  String? _type;
PaymentModel copyWith({  num? id,
  String? type,
}) => PaymentModel(  id: id ?? _id,
  type: type ?? _type,
);
  num? get id => _id;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['type'] = _type;
    return map;
  }

}
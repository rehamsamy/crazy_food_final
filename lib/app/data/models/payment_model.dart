/// id : 1
///
///
/// type : "visa1"
import 'package:get/get.dart';

class Payment {
  List<PaymentModel>? payments;
  Payment.fromJson(dynamic json) {
    if (json!= null) {
      payments = [];
      json.forEach((v) {
        payments?.add(PaymentModel.fromJson(v));
      });
      Get.log('step1');
    }else{
      Get.log('step2');
    }
  }

}
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
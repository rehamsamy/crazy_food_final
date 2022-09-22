

class LoginModel {
  LoginModel({
      String? localId, 
      String? email, 
      String? name, 
      String? displayName, 
      String? idToken, 
      bool? registered, 
      String? refreshToken, 
      String? expiresIn,}){
    _localId = localId;
    _email = email;
    _name = name;
    _displayName = displayName;
    _idToken = idToken;
    _registered = registered;
    _refreshToken = refreshToken;
    _expiresIn = expiresIn;
}

  LoginModel.fromJson(dynamic json) {
    _localId = json['localId'];
    _email = json['email'];
    _name = json['displayName'];
    _displayName = json['displayName'];
    _idToken = json['idToken'];
    _registered = json['registered'];
    _refreshToken = json['refreshToken'];
    _expiresIn = json['expiresIn'];
  }
  String? _localId;
  String? _email;
  String? _name;
  String? _displayName;
  String? _idToken;
  bool? _registered;
  String? _refreshToken;
  String? _expiresIn;
LoginModel copyWith({  String? localId,
  String? email,
  String? name,
  String? displayName,
  String? idToken,
  bool? registered,
  String? refreshToken,
  String? expiresIn,
}) => LoginModel(  localId: localId ?? _localId,
  email: email ?? _email,
  name: name ?? _name,
  displayName: displayName ?? _displayName,
  idToken: idToken ?? _idToken,
  registered: registered ?? _registered,
  refreshToken: refreshToken ?? _refreshToken,
  expiresIn: expiresIn ?? _expiresIn,
);
  String? get localId => _localId;
  String? get email => _email;
  String? get name => _name;
  String? get displayName => _displayName;
  String? get idToken => _idToken;
  bool? get registered => _registered;
  String? get refreshToken => _refreshToken;
  String? get expiresIn => _expiresIn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['localId'] = _localId;
    map['email'] = _email;
    map['displayName'] = _name;
    map['displayName'] = _displayName;
    map['idToken'] = _idToken;
    map['registered'] = _registered;
    map['refreshToken'] = _refreshToken;
    map['expiresIn'] = _expiresIn;
    return map;
  }

}
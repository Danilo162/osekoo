class Users {

  int id;
  String _nom;
  String _prenom;
  String _tel;
  String _email;
  String _photo;
  String _param_id;

  Users(this._nom, this._prenom, this._tel, this._email, this._photo, this._param_id);
  Users.map(dynamic obj) {
    this._nom = obj["nom"];
    this._prenom = obj["prenom"];
    this._tel = obj["tel"];
    this._email = obj["email"];
    this._photo = obj["photo"];
    this._param_id = obj["param_id"];
  }

  String get nom => _nom;
  String get prenom => _prenom;
  String get tel => _tel;
  String get email => _email;
  String get photo => _photo;
  String get param_id => _param_id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["nom"] = _nom;
    map["prenom"] = _prenom;
    map["tel"] = _tel;
    map["email"] = _email;
    map["photo"] = _photo;
    map["param_id"] = _param_id;

    return map;
  }

  void setUsersId(int id) {
    this.id = id;
  }
  void setparamId(String param_id) {
    this._param_id = param_id;
  }
}

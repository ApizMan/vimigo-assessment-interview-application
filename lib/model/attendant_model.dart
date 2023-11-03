class AttendantModel {
  String? user;
  String? phone;
  String? checkIn;

  AttendantModel({this.user, this.phone, this.checkIn});

  AttendantModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    phone = json['phone'];
    checkIn = json['check-in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user'] = user;
    data['phone'] = phone;
    data['check-in'] = checkIn;
    return data;
  }
}

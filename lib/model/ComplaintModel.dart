class ComplaintModel {
  bool? status;
  String? message;
  Data? data;

  ComplaintModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? message;
  String? name;
  String? email;
  String? phone;
  int? id;

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }
}

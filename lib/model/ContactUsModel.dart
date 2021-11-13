class ContactUsModel {
  bool? status;
  Data? data;

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<ContactData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(new ContactData.fromJson(v));
    });
  }
}

class ContactData {
  int? id;
  int? type;
  String? value;
  String? image;

  ContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }
}

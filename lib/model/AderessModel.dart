class AddressModel {
  late bool status;
  String? message;
  Data? data;

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<AddressData> data = [];
  int? from;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(new AddressData.fromJson(v));
    });
    from = json['from'];
    to = json['to'];
    total = json['total'];
  }
}

class AddressData {
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;
  int? id;

  AddressData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    id = json['id'];
  }
}

class NotificationsModel {
  bool? status;
  Data? data;

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<NotificatinData> data = [];
  int? from;
  int? perPage;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((v) {
      data.add(new NotificatinData.fromJson(v));
    });
    from = json['from'];
    to = json['to'];
    total = json['total'];
  }
}

class NotificatinData {
  int? id;
  String? title;
  String? message;

  NotificatinData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
  }
}

class SettingsModel {
  bool? status;
  Data? data;

  SettingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? about;
  String? terms;

  Data.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    terms = json['terms'];
  }
}

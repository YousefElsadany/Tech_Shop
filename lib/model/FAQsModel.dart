class FAQsModel {
  bool? status;
  Data? data;

  FAQsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<FQAData> data = [];
  dynamic from;
  dynamic to;
  dynamic total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((v) {
      data.add(new FQAData.fromJson(v));
    });
    from = json['from'];
    to = json['to'];
    total = json['total'];
  }
}

class FQAData {
  int? id;
  String? question;
  String? answer;

  FQAData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }
}

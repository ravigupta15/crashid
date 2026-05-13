class PageContentResponseModel {
  bool? success;
  String? message;
  Data? data;

  PageContentResponseModel({this.success, this.message, this.data});

  PageContentResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? slug;
  String? titleEn;
  String? titleDe;
  String? contentEn;
  String? contentDe;
  String? updatedAt;

  Data(
      {this.slug,
      this.titleEn,
      this.titleDe,
      this.contentEn,
      this.contentDe,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    titleEn = json['title_en'];
    titleDe = json['title_de'];
    contentEn = json['content_en'];
    contentDe = json['content_de'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['slug'] = slug;
    data['title_en'] = titleEn;
    data['title_de'] = titleDe;
    data['content_en'] = contentEn;
    data['content_de'] = contentDe;
    data['updated_at'] = updatedAt;
    return data;
  }
}

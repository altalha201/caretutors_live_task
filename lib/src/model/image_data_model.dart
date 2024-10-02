class ImageDataModel {
  String? copyright;
  String? date;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;

  ImageDataModel(
      {this.copyright,
        this.date,
        this.hdurl,
        this.mediaType,
        this.serviceVersion,
        this.title,
        this.url});

  ImageDataModel.fromJson(Map<String, dynamic> json) {
    copyright = json['copyright'];
    date = json['date'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
  }
}

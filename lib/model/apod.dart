class Apod {
  String? copyright;
  DateTime date;
  String? explanation;
  String hdurl;
  String mediaType;
  String serviceVersion;
  String title;
  String url;

  Apod({
    required this.copyright,
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });

  factory Apod.fromjson(Map<String, dynamic> json) => Apod(
      copyright: json["copyright"] ?? "Unknown",
      date: DateTime.parse(json["date"]),
      explanation: json["explanation"] ?? "No explanation available",
      hdurl: json["hdurl"] ?? "",
      mediaType: json["mediaType"] ?? "",
      serviceVersion: json["serviceVersion"] ?? "",
      title: json["title"] ?? "no title",
      url: json["url"] ?? "");
}

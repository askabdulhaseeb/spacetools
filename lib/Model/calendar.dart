import 'dart:convert';

List<Calendar> calendarFromJson(String str) =>
    List<Calendar>.from(json.decode(str).map((x) => Calendar.fromJson(x)));

String calendarToJson(List<Calendar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calendar {
  Calendar({
    required this.name,
    required this.supply,
    required this.date,
    required this.countDown,
    required this.image,
    required this.discordDesc,
    required this.mint,
    required this.twitterDesc,
    required this.website,
    required this.discordLink,
    required this.twitterLink,
  });

  String name;
  String supply;
  String date;
  String? countDown;
  String image;
  String discordDesc;
  String mint;
  String twitterDesc;
  String? website;
  String discordLink;
  String twitterLink;

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        name: json["name"],
        supply: json["supply"],
        date: json["date"],
        countDown: json["countDown"],
        image: json["image"],
        discordDesc: json["discordDesc"] ?? json["discord"],
        mint: json["mint"] ?? json["mintPrice"],
        twitterDesc: json["twitterDesc"] ?? json["twitter"],
        website: json["website"],
        discordLink: json["discordLink"],
        twitterLink: json["twitterLink"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "supply": supply,
        "date": date,
        "countDown": countDown,
        "image": image,
        "discordDesc": discordDesc,
        "mint": mint,
        "twitterDesc": twitterDesc,
        "website": website,
        "discordLink": discordLink,
        "twitterLink": twitterLink,
      };
}

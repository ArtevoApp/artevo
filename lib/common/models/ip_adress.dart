import 'dart:convert';

class IpAddress {
  final String country;
  final String regionName;
  final String city;
  final String timezone;
  final String query;

  IpAddress({
    required this.country,
    required this.regionName,
    required this.city,
    required this.timezone,
    required this.query,
  });

  factory IpAddress.fromJson(String str) =>
      IpAddress.fromMap(json.decode(str) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());

  factory IpAddress.fromMap(Map<String, dynamic> json) => IpAddress(
        country: json["country"].toString(),
        regionName: json["regionName"].toString(),
        city: json["city"].toString(),
        timezone: json["timezone"].toString(),
        query: json["query"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "country": country,
        "regionName": regionName,
        "city": city,
        "timezone": timezone,
        "query": query,
      };
}

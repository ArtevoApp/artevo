class IpAddress {
  IpAddress._();

  static final instance = IpAddress._();

  late String query; // ip adress
  late String status;
  late String city;

  IpAddress({
    required this.query,
    required this.status,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {'query': query, 'status': status, 'city': city};
  }

  factory IpAddress.fromMap(Map<String, dynamic> map) {
    return IpAddress(
        query: map['query'], status: map['status'], city: map['city']);
  }

  IpAddress.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    status = json['status'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['status'] = status;
    data['city'] = city;
    return data;
  }

  @override
  String toString() => 'IpGeo(query: $query status: $status, city: $city)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IpAddress && other.status == status && other.city == city;
  }

  @override
  int get hashCode => status.hashCode ^ city.hashCode;
}

import 'package:artevo/common/models/ip_adress.dart';

class ContentRating {
  String uuid;
  String date;
  String comment;
  double rating;
  IpAddress ip;
  ContentRating({
    required this.uuid,
    required this.date,
    required this.comment,
    required this.rating,
    required this.ip,
  });

  ContentRating copyWith({
    String? uuid,
    String? date,
    String? comment,
    double? rating,
    IpAddress? ip,
  }) {
    return ContentRating(
      uuid: uuid ?? this.uuid,
      date: date ?? this.date,
      comment: comment ?? this.comment,
      rating: rating ?? this.rating,
      ip: ip ?? this.ip,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'date': date,
      'comment': comment,
      'rating': rating,
      'ip': ip.toMap(),
    };
  }

  factory ContentRating.fromMap(Map<String, dynamic> map) {
    return ContentRating(
      uuid: map['uuid'] ?? '',
      date: map['date'] ?? '',
      comment: map['comment'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      ip: IpAddress.fromMap(map['ip']),
    );
  }
}

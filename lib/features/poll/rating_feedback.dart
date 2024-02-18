import 'dart:convert';

import 'package:artevo/common/models/ip_adress.dart';

class RatingFeedBack {
  String uuid;
  String date;
  String comment;
  double rating;
  IpAddress ip;
  RatingFeedBack({
    required this.uuid,
    required this.date,
    required this.comment,
    required this.rating,
    required this.ip,
  });

  RatingFeedBack copyWith({
    String? uuid,
    String? date,
    String? comment,
    double? rating,
    IpAddress? ip,
  }) {
    return RatingFeedBack(
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

  factory RatingFeedBack.fromMap(Map<String, dynamic> map) {
    return RatingFeedBack(
      uuid: map['uuid'] ?? '',
      date: map['date'] ?? '',
      comment: map['comment'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      ip: IpAddress.fromMap(map['ip']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RatingFeedBack.fromJson(String source) =>
      RatingFeedBack.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RatingFeedBack(uuid: $uuid, date: $date, comment: $comment, rating: $rating, ip: $ip)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RatingFeedBack &&
        other.uuid == uuid &&
        other.date == date &&
        other.comment == comment &&
        other.rating == rating &&
        other.ip == ip;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
        date.hashCode ^
        comment.hashCode ^
        rating.hashCode ^
        ip.hashCode;
  }
}

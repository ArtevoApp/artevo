// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaylistInfo {
  String id;
  String name;
  String coverContentID;
  String coverTitle;
  String description;
  String coverUrl;
  int createdAt;
  PlaylistInfo({
    required this.id,
    required this.name,
    required this.coverContentID,
    required this.coverTitle,
    required this.description,
    required this.coverUrl,
    required this.createdAt,
  });

  PlaylistInfo copyWith({
    String? id,
    String? name,
    String? coverContentID,
    String? coverTitle,
    String? description,
    String? coverUrl,
    int? createdAt,
  }) {
    return PlaylistInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      coverContentID: coverContentID ?? this.coverContentID,
      coverTitle: coverTitle ?? this.coverTitle,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'coverContentID': coverContentID,
      'coverTitle': coverTitle,
      'description': description,
      'coverUrl': coverUrl,
      'createdAt': createdAt,
    };
  }

  factory PlaylistInfo.fromMap(Map<String, dynamic> map) {
    return PlaylistInfo(
      id: map['id'] as String,
      name: map['name'] as String,
      coverContentID: map['coverContentID'] as String,
      coverTitle: map['coverTitle'] as String,
      description: map['description'] as String,
      coverUrl: map['coverUrl'] as String,
      createdAt: map['createdAt'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaylistInfo.fromJson(String source) =>
      PlaylistInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlaylistInfo(id: $id, name: $name, coverContentID: $coverContentID, coverTitle: $coverTitle, description: $description, coverUrl: $coverUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant PlaylistInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.coverContentID == coverContentID &&
        other.coverTitle == coverTitle &&
        other.description == description &&
        other.coverUrl == coverUrl &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        coverContentID.hashCode ^
        coverTitle.hashCode ^
        description.hashCode ^
        coverUrl.hashCode ^
        createdAt.hashCode;
  }
}

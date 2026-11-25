import 'package:json_annotation/json_annotation.dart';

part 'award.g.dart';

/// Portfolio award synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Award {
  const Award({
    required this.title,
    required this.issuer,
    required this.tier,
    required this.date,
    required this.description,
    this.id,
    this.certificateUrl = '',
    this.isWinner = false,
    this.createdAt,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Award.fromJson(Map<String, dynamic> json) => _$AwardFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String issuer;
  final String tier;
  final String date;
  final String description;

  @JsonKey(defaultValue: '')
  final String certificateUrl;

  @JsonKey(defaultValue: false)
  final bool isWinner;

  @JsonKey(includeToJson: false)
  final String? createdAt;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$AwardToJson(this);

  Award copyWith({
    String? id,
    String? title,
    String? issuer,
    String? tier,
    String? date,
    String? description,
    String? certificateUrl,
    bool? isWinner,
    String? createdAt,
    int? starCount,
    bool? isStarred,
    String? starredByNames,
  }) {
    return Award(
      id: id ?? this.id,
      title: title ?? this.title,
      issuer: issuer ?? this.issuer,
      tier: tier ?? this.tier,
      date: date ?? this.date,
      description: description ?? this.description,
      certificateUrl: certificateUrl ?? this.certificateUrl,
      isWinner: isWinner ?? this.isWinner,
      createdAt: createdAt ?? this.createdAt,
      starCount: starCount ?? this.starCount,
      isStarred: isStarred ?? this.isStarred,
      starredByNames: starredByNames ?? this.starredByNames,
    );
  }
}

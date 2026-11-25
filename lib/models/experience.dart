import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Portfolio experience synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.title,
    required this.category,
    required this.description,
    this.id,
    this.categoryDisplay = '',
    this.thumbnail = '',
    this.startedAt,
    this.endedAt,
    this.isOngoing = false,
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;

  final String title;
  final String category;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String categoryDisplay;

  final String description;

  @JsonKey(defaultValue: '')
  final String? thumbnail;

  @JsonKey(includeToJson: false)
  final String? startedAt;

  final String? endedAt;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isOngoing;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}

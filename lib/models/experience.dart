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
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
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
  final String thumbnail;

  @JsonKey(includeToJson: false)
  final String? startedAt;

  final String? endedAt;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isOngoing;

  @JsonKey(includeToJson: false, defaultValue: 0)
  final int starCount;

  @JsonKey(includeToJson: false, defaultValue: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);

  Experience copyWith({
    String? id,
    String? title,
    String? category,
    String? categoryDisplay,
    String? description,
    String? thumbnail,
    String? startedAt,
    String? endedAt,
    bool clearEndedAt = false,
    bool? isOngoing,
    int? starCount,
    bool? isStarred,
    String? starredByNames,
  }) {
    return Experience(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      categoryDisplay: categoryDisplay ?? this.categoryDisplay,
      description: description ?? this.description,
      thumbnail: thumbnail ?? this.thumbnail,
      startedAt: startedAt ?? this.startedAt,
      endedAt: clearEndedAt ? null : (endedAt ?? this.endedAt),
      isOngoing: isOngoing ?? this.isOngoing,
      starCount: starCount ?? this.starCount,
      isStarred: isStarred ?? this.isStarred,
      starredByNames: starredByNames ?? this.starredByNames,
    );
  }
}

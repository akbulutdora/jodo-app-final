import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'jodo.freezed.dart';

part 'jodo.g.dart';

enum JodoType {
  todo,
  @JsonValue('text')
  note,
}

/// This is the model class for a [Jodo].
/// A Jodo can either be a Todo: [JodoType.todo] or a Note: [JodoType.note].
@freezed
class Jodo with _$Jodo {
  const Jodo._();

  factory Jodo.empty() {
    return const Jodo(
      title: '',
      text: '',
      completedAt: null,
      type: JodoType.note,
    );
  }

  const factory Jodo({
    required String title,
    @JsonKey(name: 'description') String? text,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    int? id,
    DateTime? createdAt,
    required JodoType type,
  }) = _Jodo;

  factory Jodo.fromJson(Map<String, Object?> json) => _$JodoFromJson(json);
}

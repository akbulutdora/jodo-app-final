// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jodo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Jodo _$$_JodoFromJson(Map<String, dynamic> json) => _$_Jodo(
      title: json['title'] as String,
      text: json['description'] as String?,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      id: json['id'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      type: $enumDecode(_$JodoTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_JodoToJson(_$_Jodo instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.text,
      'completed_at': instance.completedAt?.toIso8601String(),
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'type': _$JodoTypeEnumMap[instance.type]!,
    };

const _$JodoTypeEnumMap = {
  JodoType.todo: 'todo',
  JodoType.note: 'text',
};

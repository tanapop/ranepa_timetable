// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineParent _$TimelineParentFromJson(Map<String, dynamic> json) {
  return TimelineParent(TimelineParent._userFromInt(json['user'] as int),
      DateTime.parse(json['date'] as String));
}

Map<String, dynamic> _$TimelineParentToJson(TimelineParent instance) =>
    <String, dynamic>{
      'user': TimelineParent._userToInt(instance.user),
      'date': instance.date.toIso8601String()
    };

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) {
  return TimelineModel(
      date: DateTime.parse(json['date'] as String),
      start: TimelineModel._timeOfDayFromIntList(
          json['start'] as Map<String, int>),
      finish: TimelineModel._timeOfDayFromIntList(
          json['finish'] as Map<String, int>),
      room: RoomModel.fromJson(json['room'] as Map<String, dynamic>),
      group: json['group'] as String,
      lesson: LessonModel.fromJson(json['lesson'] as Map<String, dynamic>),
      teacher: TeacherModel.fromJson(json['teacher'] as Map<String, dynamic>),
      user: TimelineParent._userFromInt(json['user'] as int),
      first: json['first'] as bool,
      last: json['last'] as bool);
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'user': TimelineParent._userToInt(instance.user),
      'date': instance.date.toIso8601String(),
      'lesson': instance.lesson,
      'room': instance.room,
      'group': instance.group,
      'teacher': instance.teacher,
      'first': instance.first,
      'last': instance.last,
      'start': TimelineModel._timeOfDayToIntList(instance.start),
      'finish': TimelineModel._timeOfDayToIntList(instance.finish)
    };

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) {
  return RoomModel(json['number'] as int,
      _$enumDecode(_$RoomLocationEnumMap, json['location']));
}

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'number': instance.number,
      'location': _$RoomLocationEnumMap[instance.location]
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

const _$RoomLocationEnumMap = <RoomLocation, dynamic>{
  RoomLocation.Academy: 'Academy',
  RoomLocation.Hotel: 'Hotel',
  RoomLocation.StudyHostel: 'StudyHostel'
};

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) {
  return LessonModel(json['title'] as String, json['iconCodePoint'] as int,
      type: _$enumDecode(_$LessonTypeEnumMap, json['type']));
}

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'iconCodePoint': instance.iconCodePoint,
      'type': _$LessonTypeEnumMap[instance.type]
    };

const _$LessonTypeEnumMap = <LessonType, dynamic>{
  LessonType.Theory: 'Theory',
  LessonType.Practice: 'Practice'
};

TeacherModel _$TeacherModelFromJson(Map<String, dynamic> json) {
  return TeacherModel(json['name'] as String, json['surname'] as String,
      json['patronymic'] as String);
}

Map<String, dynamic> _$TeacherModelToJson(TeacherModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic
    };
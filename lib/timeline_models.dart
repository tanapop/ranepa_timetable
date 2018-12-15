/* Copyright 2018 Rejish Radhakrishnan

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ranepa_timetable/localizations.dart';
import 'package:ranepa_timetable/timetable_icons.dart';

part 'timeline_models.g.dart';

enum TimelineUser { Student, Teacher }

@JsonSerializable(nullable: false)
class TimelineParent {
  final TimelineUser user;
  final DateTime date;

  TimelineParent(this.user, this.date);
}

@JsonSerializable(nullable: false)
class TimelineModel extends TimelineParent {
  final LessonModel lesson;
  final RoomModel room;
  final String group;
  final TeacherModel teacher;

  bool first, last;
  bool mergeBottom, mergeTop;

  @JsonKey(fromJson: _timeOfDayFromIntList, toJson: _timeOfDayToIntList)
  final TimeOfDay start, finish;

  static TimeOfDay _timeOfDayFromIntList(Map<String, dynamic> map) =>
      TimeOfDay(hour: map["hour"], minute: map["minute"]);

  static Map<String, dynamic> _timeOfDayToIntList(TimeOfDay timeOfDay) =>
      {"hour": timeOfDay.hour, "minute": timeOfDay.minute};

  TimelineModel({
    @required DateTime date,
    @required this.start,
    @required this.finish,
    @required this.room,
    @required this.group,
    @required this.lesson,
    @required this.teacher,
    @required TimelineUser user,
    this.first = false,
    this.last = false,
    this.mergeBottom = false,
    this.mergeTop = false,
  }) : super(user, date);

  factory TimelineModel.fromJson(Map<String, dynamic> json) =>
      _$TimelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineModelToJson(this);
}

enum RoomLocation { Academy, Hotel, StudyHostel }

@JsonSerializable(nullable: false)
class RoomModel {
  final String number;
  final RoomLocation location;

  const RoomModel(this.number, this.location);

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  factory RoomModel.fromString(String str) {
    return RoomModel(
        RegExp(r"(\d{3}[А-я]?)").stringMatch(str),
        str.startsWith("СО")
            ? RoomLocation.StudyHostel
            : str.startsWith("П8") ? RoomLocation.Hotel : RoomLocation.Academy);
  }
}

enum LessonType { None, Theory, Practice }

String parseLessonTitle(String str) {
  final openBracketIndex = str.indexOf('('),
      title = str.substring(
          0, openBracketIndex != -1 ? openBracketIndex : str.length - 1);
  return title[0].toUpperCase() + title.substring(1);
}

LessonType parseLessonType(String str) {
  var openBracketIndex = str.indexOf('(');
  if (openBracketIndex == -1) openBracketIndex = 0;
  final lowerTitle = str.substring(openBracketIndex).toLowerCase();
  debugPrint("m lower title: $lowerTitle");

  return (lowerTitle.contains("практ") || lowerTitle.contains("семин"))
      ? LessonType.Practice
      : (lowerTitle.contains("лекци") ? LessonType.Theory : LessonType.None);
}

@JsonSerializable(nullable: false)
class LessonModel {
  @JsonKey(ignore: true)
  String fullTitle;
  @JsonKey(ignore: true)
  final List<List<String>> findWords;
  final String title;
  final int iconCodePoint;
  LessonType lessonType;

  LessonModel(this.title, this.iconCodePoint, this.findWords,
      {this.lessonType = LessonType.None, this.fullTitle});

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  factory LessonModel.fromString(BuildContext context, String str) {
    final types = LessonTypes(context);
    final lowerStr = str.toLowerCase();

    LessonModel model;

    // TODO: parse lessonsss
    for(final mLesson in types.lessons) {
      bool strFound;
      for(final List<String> mStrList in mLesson.findWords) {
        for(final String mStr in mStrList) {
          if(!lowerStr.contains(mStr)) {

          }
        }
      }
    }

//    if (lowerStr.contains("математик"))
//      model = types.math;
//    else if (lowerStr.contains("общество"))
//      model = types.socialStudies;
//    else if (lowerStr.contains("экономик") ||
//        (lowerStr.contains("экономическ") && lowerStr.contains("теори")))
//      model = types.economics;
//    else if (lowerStr.contains("теори") && lowerStr.contains("информаци"))
//      return types.informationTheory;
//    else if (lowerStr.contains("философи"))
//      model = types.philosophy;
//    else if (lowerStr.contains("культур") && lowerStr.contains("реч"))
//      return types.speechCulture;
//    else if (lowerStr.contains("физик"))
//      model = types.physics;
//    else if (lowerStr.contains("хими"))
//      model = types.chemistry;
//    else if (lowerStr.contains("литератур"))
//      model = types.literature;
//    else if (lowerStr.contains("иностранн") || lowerStr.contains("английск"))
//      model = types.english;
//    else if (lowerStr.contains("информатик"))
//      model = types.informatics;
//    else if (lowerStr.contains("географи"))
//      model = types.geography;
//    else if (lowerStr.contains("истори"))
//      model = types.history;
//    else if (lowerStr.contains("обж") ||
//        (lowerStr.contains("безопасност") &&
//            lowerStr.contains("жизнедеятельност")))
//      return types.lifeSafety;
//    else if (lowerStr.contains("биологи"))
//      model = types.biology;
//    else if (lowerStr.contains("физ") && lowerStr.contains("культур"))
//      return types.physicalCulture;
//    else if (lowerStr.contains("этик"))
//      model = types.ethics;
//    else if (lowerStr.contains("менеджмент"))
//      model = types.management;
//    else if (lowerStr.contains("разработ") &&
//        ((lowerStr.contains("програмн") && lowerStr.contains("обеспечени")) ||
//            lowerStr.contains("ПО")))
//      model = types.softwareDevelopment;
//    else if (lowerStr.contains("архитектур") &&
//        (lowerStr.contains("эвм") || lowerStr.contains("пк")))
//      model = types.computerArchitecture;
//    else if (lowerStr.contains("операционн") && lowerStr.contains("систем"))
//      model = types.operatingSystems;
//    else if (lowerStr.contains("компьютерн") && lowerStr.contains("график"))
//      model = types.computerGraphic;
//    else if (lowerStr.contains("проектн"))
//      model = types.projectDevelopment;
//    else if (lowerStr.contains("баз") && lowerStr.contains("данн"))
//      model = types.databases;
//    else if (lowerStr.contains("обеспеч") &&
//        lowerStr.contains("управл") &&
//        lowerStr.contains("документ"))
//      model = types.documentManagementSupport;
//    else if (lowerStr.contains("инвентар"))
//      model = types.inventory;
//    else if (lowerStr.contains("бухучет"))
//      model = types.accounting;
//    else if (lowerStr.contains("планирован") && lowerStr.contains("бизнес"))
//      model = types.businessPlanning;
//    else if (lowerStr.contains("налогообложен"))
//      model = types.taxation;
//    else if (lowerStr.contains("расчет") && lowerStr.contains("бюдж"))
//      model = types.budgetCalculations;
//    else if (lowerStr.contains("анализ") && lowerStr.contains("бухгалтер"))
//      model = types.accountingAnalysis;
//    else
//      model = LessonModel(parseLessonTitle(lowerStr),
//          TimetableIcons.unknownLesson.codePoint); // Use original title

    model.fullTitle = str;
    model.lessonType = parseLessonType(str);

    return model;
  }
}

enum LessonIds {
  math,
  economics,
  informationTheory,
  philosophy,
  speechCulture,
  physics,
  chemistry,
  literature,
  english,
  informatics,
  geography,
  history,
  lifeSafety,
  biology,
  socialStudies,
  physicalCulture,
  ethics,
  management,
  softwareDevelopment,
  computerArchitecture,
  operatingSystems,
  computerGraphic,
  projectDevelopment,
  databases,
  documentManagementSupport,
  accounting,
  accountingAnalysis,
  budgetCalculations,
  taxation,
  businessPlanning,
  inventory
}

class LessonTypes {
  static LessonTypes _singleton;

  factory LessonTypes(BuildContext context) {
    if (_singleton == null) _singleton = LessonTypes._internal(context);

    return _singleton;
  }

  LessonTypes._internal(this.context)
      : lessons =
            List<LessonModel>.generate(LessonIds.values.length, (lessonIndex) {
          switch (LessonIds.values[lessonIndex]) {
            case LessonIds.math:
              return LessonModel(
                AppLocalizations.of(context).math,
                TimetableIcons.math.codePoint,
                <List<String>>[
                  <String>["математик"]
                ],
              );
            case LessonIds.economics:
              return LessonModel(
                AppLocalizations.of(context).economics,
                TimetableIcons.economics.codePoint,
                <List<String>>[
                  <String>["экономик"],
                  <String>["экономическ", "теори"]
                ],
              );
            case LessonIds.informationTheory:
              return LessonModel(
                AppLocalizations.of(context).informationTheory,
                TimetableIcons.informationTheory.codePoint,
                <List<String>>[
                  <String>["теори", "информаци"]
                ],
              );
            case LessonIds.philosophy:
              return LessonModel(
                AppLocalizations.of(context).philosophy,
                TimetableIcons.philosophy.codePoint,
                <List<String>>[
                  <String>["философи"]
                ],
              );
            case LessonIds.speechCulture:
              return LessonModel(
                AppLocalizations.of(context).speechCulture,
                TimetableIcons.speechCulture.codePoint,
                <List<String>>[
                  <String>["культур", "реч"]
                ],
              );
            case LessonIds.physics:
              return LessonModel(
                AppLocalizations.of(context).physics,
                TimetableIcons.physics.codePoint,
                <List<String>>[
                  <String>["физик"]
                ],
              );
            case LessonIds.chemistry:
              return LessonModel(
                AppLocalizations.of(context).chemistry,
                TimetableIcons.chemistry.codePoint,
                <List<String>>[
                  <String>["хими"]
                ],
              );
            case LessonIds.literature:
              return LessonModel(
                AppLocalizations.of(context).literature,
                TimetableIcons.literature.codePoint,
                <List<String>>[
                  <String>["литератур"]
                ],
              );
            case LessonIds.english:
              return LessonModel(
                AppLocalizations.of(context).english,
                TimetableIcons.english.codePoint,
                <List<String>>[
                  <String>["иностранн"],
                  <String>["английск"]
                ],
              );
            case LessonIds.informatics:
              return LessonModel(
                AppLocalizations.of(context).informatics,
                TimetableIcons.informatics.codePoint,
                <List<String>>[
                  <String>["информатик"]
                ],
              );
            case LessonIds.geography:
              return LessonModel(
                AppLocalizations.of(context).geography,
                TimetableIcons.geography.codePoint,
                <List<String>>[
                  <String>["географи"]
                ],
              );
            case LessonIds.history:
              return LessonModel(
                AppLocalizations.of(context).history,
                TimetableIcons.history.codePoint,
                <List<String>>[
                  <String>["истори"]
                ],
              );
            case LessonIds.lifeSafety:
              return LessonModel(
                AppLocalizations.of(context).lifeSafety,
                TimetableIcons.lifeSafety.codePoint,
                <List<String>>[
                  <String>["биологи"]
                ],
              );
            case LessonIds.biology:
              return LessonModel(
                AppLocalizations.of(context).biology,
                TimetableIcons.biology.codePoint,
                <List<String>>[
                  <String>["биологи"]
                ],
              );
            case LessonIds.socialStudies:
              return LessonModel(
                AppLocalizations.of(context).socialStudies,
                TimetableIcons.socialStudies.codePoint,
                <List<String>>[
                  <String>["общество"]
                ],
              );
            case LessonIds.physicalCulture:
              return LessonModel(
                AppLocalizations.of(context).physicalCulture,
                TimetableIcons.physicalCulture.codePoint,
                <List<String>>[
                  <String>["физ", "культур"]
                ],
              );
            case LessonIds.ethics:
              return LessonModel(
                AppLocalizations.of(context).ethics,
                TimetableIcons.ethics.codePoint,
                <List<String>>[
                  <String>["этик"]
                ],
              );
            case LessonIds.management:
              return LessonModel(
                AppLocalizations.of(context).management,
                TimetableIcons.management.codePoint,
                <List<String>>[
                  <String>["менеджмент"]
                ],
              );
            case LessonIds.softwareDevelopment:
              return LessonModel(
                AppLocalizations.of(context).softwareDevelopment,
                TimetableIcons.softwareDevelopment.codePoint,
                <List<String>>[
                  <String>["разработ", "програмн", "обеспечени"],
                  <String>["разработ", "по"]
                ],
              );
            case LessonIds.computerArchitecture:
              return LessonModel(
                AppLocalizations.of(context).computerArchitecture,
                TimetableIcons.computerArchitecture.codePoint,
                <List<String>>[
                  <String>["архитектур", "эвм"],
                  <String>["архитектур", "пк"]
                ],
              );
            case LessonIds.operatingSystems:
              return LessonModel(
                AppLocalizations.of(context).operatingSystems,
                TimetableIcons.operatingSystems.codePoint,
                <List<String>>[
                  <String>["операционн", "систем"]
                ],
              );
            case LessonIds.computerGraphic:
              return LessonModel(
                AppLocalizations.of(context).computerGraphic,
                TimetableIcons.computerGraphic.codePoint,
                <List<String>>[
                  <String>["компьютерн", "график"]
                ],
              );
            case LessonIds.projectDevelopment:
              return LessonModel(
                AppLocalizations.of(context).projectDevelopment,
                TimetableIcons.projectDevelopment.codePoint,
                <List<String>>[
                  <String>["проектн"]
                ],
              );
            case LessonIds.databases:
              return LessonModel(
                AppLocalizations.of(context).databases,
                TimetableIcons.databases.codePoint,
                <List<String>>[
                  <String>["баз", "данн"]
                ],
              );
            case LessonIds.documentManagementSupport:
              return LessonModel(
                AppLocalizations.of(context).documentManagementSupport,
                TimetableIcons.documentManagementSupport.codePoint,
                <List<String>>[
                  <String>["обеспеч", "управл", "документ"]
                ],
              );
            case LessonIds.accounting:
              return LessonModel(
                AppLocalizations.of(context).accounting,
                TimetableIcons.accounting.codePoint,
                <List<String>>[
                  <String>["бухучет"]
                ],
              );
            case LessonIds.accountingAnalysis:
              return LessonModel(
                AppLocalizations.of(context).accountingAnalysis,
                TimetableIcons.accountingAnalysis.codePoint,
                <List<String>>[
                  <String>["анализ", "бухгалтер"]
                ],
              );
            case LessonIds.budgetCalculations:
              return LessonModel(
                AppLocalizations.of(context).budgetCalculations,
                TimetableIcons.budgetCalculations.codePoint,
                <List<String>>[
                  <String>["расчет", "бюдж"]
                ],
              );
            case LessonIds.taxation:
              return LessonModel(
                AppLocalizations.of(context).taxation,
                TimetableIcons.taxation.codePoint,
                <List<String>>[
                  <String>["налогообложен"]
                ],
              );
            case LessonIds.businessPlanning:
              return LessonModel(
                AppLocalizations.of(context).businessPlanning,
                TimetableIcons.businessPlanning.codePoint,
                <List<String>>[
                  <String>["планирован", "бизнес"]
                ],
              );
            case LessonIds.inventory:
              return LessonModel(
                AppLocalizations.of(context).inventory,
                TimetableIcons.inventory.codePoint,
                <List<String>>[
                  <String>["инвентар"]
                ],
              );
          }
        });

  final BuildContext context;

  final List<LessonModel> lessons;
}

@JsonSerializable(nullable: false)
class TeacherModel {
  const TeacherModel(this.name, this.surname, this.patronymic);

  final String name, surname, patronymic;

  factory TeacherModel.fromJson(Map<String, dynamic> json) =>
      _$TeacherModelFromJson(json);

  Map<String, dynamic> toJson() => _$TeacherModelToJson(this);

  factory TeacherModel.fromString(String respName) {
    final words = respName
        .substring(respName.lastIndexOf('>') + 1)
        .split(new RegExp(r"\s+"));
    return TeacherModel(words[words.length - 2], words[words.length - 3],
        words[words.length - 1]);
  }

  @override
  String toString() => "$surname $name $patronymic";

  String initials() => "$surname ${name[0]}. ${patronymic[0]}.";
}

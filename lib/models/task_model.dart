// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class TaskModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String date;
  final String index;
  bool? isCompeleted;
  bool? isDeleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.index,
    this.isCompeleted,
    this.isDeleted,
  }) {
    isCompeleted = isCompeleted ?? false;
    isDeleted = isDeleted ?? false;
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? index,
    bool? isCompeleted,
    bool? isDeleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      index: index ?? this.index,
      isCompeleted: isCompeleted ?? this.isCompeleted,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        index,
        isCompeleted,
        isDeleted,
      ];
}

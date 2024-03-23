import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  int? id;
  String title;
  int? isCompleted;
  DateTime? dueDate;
  String? comments;
  String? description;
  String? tags;

  Task(
      {this.id,
      required this.title,
      this.isCompleted,
      this.dueDate,
      this.comments,
      this.description,
      this.tags});

  Task copyWith(
          {int? id,
          String? title,
          int? isCompleted,
          DateTime? dueDate,
          String? comments,
          String? description,
          String? tags}) =>
      Task(
          id: id ?? this.id,
          title: title ?? this.title,
          isCompleted: isCompleted ?? this.isCompleted,
          dueDate: dueDate ?? this.dueDate,
          comments: comments,
          description: description,
          tags: tags);

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json["id"],
      title: json["title"],
      isCompleted: json["is_completed"],
      dueDate: DateTime.parse(json["due_date"]),
      comments: json["comments"],
      description: json["description"],
      tags: json["tags"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
        "due_date":
            "${dueDate?.year.toString().padLeft(4, '0')}-${dueDate?.month.toString().padLeft(2, '0')}-${dueDate?.day.toString().padLeft(2, '0')}",
        "comments": comments,
        "description": description,
        "tags": tags
      };
}

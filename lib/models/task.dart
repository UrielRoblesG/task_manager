import 'dart:convert';

// Metodo que genera una Tarea a partir de un JSON
Task taskFromJson(String str) => Task.fromJson(json.decode(str));

// Transforma una tarea a Json
String taskToJson(Task data) => json.encode(data.toJson());

// Clase para modelar una tarea
class Task {
  int? id;
  String? title;
  int isCompleted;
  DateTime? dueDate;
  String? comments;
  String? description;
  String? tags;
  String? token;

  Task(
      {this.id,
      this.title,
      this.isCompleted = 0,
      this.dueDate,
      this.comments,
      this.description,
      this.token,
      this.tags});

  /**
   * Metodo para generar una nueva tarea en base a otro atributo 
   */
  Task copyWith(
          {int? id,
          String? title,
          int? isCompleted,
          DateTime? dueDate,
          String? comments,
          String? token = '',
          String? description,
          String? tags}) =>
      Task(
          id: id ?? this.id,
          title: title ?? this.title,
          isCompleted: isCompleted ?? this.isCompleted,
          dueDate: dueDate ?? this.dueDate,
          comments: comments ?? this.comments,
          token: token ?? this.token,
          description: description ?? this.description,
          tags: tags ?? this.tags);

  /**
   * Metodo factory para crear una tarea a partir de un map
   */
  factory Task.fromJson(Map<String, dynamic> json) => Task(
      id: json["id"],
      title: json["title"],
      isCompleted: json["is_completed"],
      dueDate: DateTime.tryParse(json["due_date"] ?? ''),
      comments: json["comments"],
      description: json["description"],
      tags: json["tags"],
      token: json["token"]);

  /**
   * Metodo para convertir una clase en un Json 
   */
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_completed": isCompleted,
        "due_date": (dueDate != null)
            ? "${dueDate?.year.toString().padLeft(4, '0')}-${dueDate?.month.toString().padLeft(2, '0')}-${dueDate?.day.toString().padLeft(2, '0')}"
            : null,
        "comments": comments,
        "description": description,
        "tags": tags,
        "token": (token == null) ? '' : ''
      };

  /**
   * Metodo para convertir la fecha en un formato yyyy-mm-dd
   */
  String? getFormatedDate() => (dueDate != null)
      ? "${dueDate?.year.toString().padLeft(4, '0')}-${dueDate?.month.toString().padLeft(2, '0')}-${dueDate?.day.toString().padLeft(2, '0')}"
      : '';

  // Transforma una clase en un formato x-www-form-urlencoded
  String encodeFormData() {
    final data = toJson();

    return data.entries
        .where(
            (entry) => entry.value != null && entry.value.toString().isNotEmpty)
        .map((entry) =>
            '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');
  }

  // Obtiene una nueva clase con solo los atributos que
  // son distintos
  hasChanged(Task task) {
    final tempTask = Task();
    tempTask.id = task.id;
    tempTask.token = '';

    if (title != task.title || title == task.title) {
      tempTask.title = task.title;
    }
    if (isCompleted != task.isCompleted) {
      tempTask.isCompleted = task.isCompleted;
    }
    if (description != task.description) {
      tempTask.description = task.description;
    }
    if (dueDate != task.dueDate) {
      tempTask.dueDate = task.dueDate;
    }
    if (tags != task.tags) {
      tempTask.tags = task.tags;
    }
    if (comments != task.comments) {
      tempTask.comments = task.comments;
    }

    return tempTask;
  }
}

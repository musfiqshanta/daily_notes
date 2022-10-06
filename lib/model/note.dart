String tableNotes = "notes";

class NoteFields {

  static final List<String> values = [
    id,
    title,
    description,
    comment,
    time,
  ];

  static final String id = '_id';
  static final String comment = "_comment";
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

class Note {
  final int? id;
  final String title;
  final String comment;
  final String description;
  final DateTime createdTime;

  const Note({
    this.id,
    required this.comment,
    required this.title,
    required this.description,
    required this.createdTime,
  });
  Map<String, Object?> tomap() => {
        NoteFields.id: id,
        NoteFields.comment: comment,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.time: createdTime.toIso8601String(),
      };

  static Note fromMap(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        comment: json[NoteFields.comment] as String,
        title: json[NoteFields.title] as String,
        description: json[NoteFields.description] as String,
        createdTime: DateTime.parse(
          json[NoteFields.time] as String,
        ),
      );

  Note copy({
    int? id,
    String? comment,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        comment: comment ?? this.comment,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
}

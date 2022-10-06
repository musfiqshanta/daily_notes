import 'package:flutter/material.dart';
import 'package:notes/db/note-database.dart';
import 'package:notes/model/note.dart';
import 'package:notes/widget/note_form.dart';

class AddEditNote extends StatefulWidget {
  final Note? note;

  const AddEditNote({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  _AddEditNoteState createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String comments;

  @override
  void initState() {
    super.initState();

    title = widget.note?.title ?? "";
    comments = widget.note?.comment ?? "";
    description = widget.note?.description ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Note",
          style: TextStyle(fontSize: 24.0),
        ),
        actions: [actionButton()],
      ),
      body: Form(
          key: _formKey,
          child: Noteform(
            title: title,
            description: description,
            onChangedTitle: (title) => setState(() => this.title = title),
            onChangedDescription: (description) {
              setState(() {
                this.description = description;
              });
            },
          )),
    );
  }

  Widget actionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.blueGrey,
        ),
        onPressed: addOrUpdateNote,
        child: Text(
          'Save',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  void addOrUpdateNote() async {
    final valid = _formKey.currentState!.validate();

    if (valid) {
      final update = widget.note != null;

      if (update) {
        await updateNote();
      } else {
        await addNote();
      }

      

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      title: title,
      description: description,
      comment: comments,
    );

    await NoteDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      title: title,
      description: description,
      createdTime: DateTime.now(),
      comment: comments,
    );
    await NoteDatabase.instance.create(note);
  }
}

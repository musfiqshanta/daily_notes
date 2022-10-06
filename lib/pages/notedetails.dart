import 'package:flutter/material.dart';
import 'package:notes/db/note-database.dart';
import 'package:notes/model/note.dart';

import 'add_edit_note.dart';

class NoteDeatails extends StatefulWidget {
  final int noteId;
  const NoteDeatails({Key? key, required this.noteId}) : super(key: key);

  @override
  _NoteDeatailsState createState() => _NoteDeatailsState();
}

class _NoteDeatailsState extends State<NoteDeatails> {
  late Note note;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    refreshNote();
    // print("NOte prin");
    // print(widget.noteId);
    // print(note.title);
  }
  

  Future refreshNote() async {
    setState(() {
      isLoading = true;
    });

    this.note = await NoteDatabase.instance.readNote(widget.noteId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Note"),
        actions: [editbutton(), delate()],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  Text(
                    note.title,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    note.description,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
            ),
    );
  }

  Widget editbutton() => IconButton(
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddEditNote(
                  note: this.note,
                )));
        refreshNote();
      },
      icon: Icon(Icons.edit));
  Widget delate() => IconButton(
      onPressed: () async {
        await NoteDatabase.instance.delete(widget.noteId);
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.delete));
}

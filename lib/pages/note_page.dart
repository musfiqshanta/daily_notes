import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/db/note-database.dart';
import 'package:notes/model/note.dart';
import 'package:notes/pages/add_edit_note.dart';
import 'package:notes/pages/search.dart';
import 'package:notes/widget/note_card.dart';

import 'notedetails.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late List<Note> notes;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  @override
  void dispose() {
    NoteDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NoteDatabase.instance.readAllNote();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notes",
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchNote()));
              refreshNotes();
            },
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddEditNote()));
          refreshNotes();
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : notes.isEmpty
              ? Text(
                  "Empty Notes",
                  style: TextStyle(color: Colors.red, fontSize: 18.0),
                )
              : buildNotes(),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
      crossAxisCount: 4,
      itemCount: notes.length,
      staggeredTileBuilder: (int index) =>
          StaggeredTile.count(2, index.isEven ? 1.2 : 2.4),
      // staggeredTileBuilder: (index) => StaggeredTile.fit(6),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemBuilder: (BuildContext context, int index) {
        final note = notes[index];

        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NoteDeatails(
                noteId: note.id!,
              ),
            ));

            refreshNotes();
          },
          child: NoteCard(
            note: note,
            index: index,
          ),
        );
      });
}

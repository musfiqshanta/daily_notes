import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/db/note-database.dart';
import 'package:notes/model/note.dart';
import 'package:notes/widget/note_card.dart';
import 'notedetails.dart';

class SearchNote extends StatefulWidget {
  const SearchNote({Key? key}) : super(key: key);

  @override
  _SearchNoteState createState() => _SearchNoteState();
}

class _SearchNoteState extends State<SearchNote> {
  late String x = 'v';

  @override
  void initState() {
    super.initState();
    print("X valu");
    print(x);
    refreshNotes('a');
  }

  late List<Note> notes;

  bool isLoading = false;

  Future refreshNotes([data]) async {
    setState(() => isLoading = true);

    this.notes = await NoteDatabase.instance.searchNote(data);

    setState(() => isLoading = false);
    print("Show note");
    print(notes.length);
  }

  @override
  Widget build(BuildContext context) {
    x = "b";
    //String? data;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.backspace)),

        title: TextField(
          style: TextStyle(fontSize: 15, color: Colors.white),
          decoration: InputDecoration(
              hintText: "Search",
              hintStyle: TextStyle(color: Colors.white60),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.white54,
              ),
              focusColor: Colors.white),
          onChanged: (value) {
            setState(() {
              x = value;
            });
            refreshNotes(x);
            print("valu of " + x);
          },
        ),

        // actions: [TextField()],
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

  Widget buildNotes() => Container(
        child: StaggeredGridView.countBuilder(
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

                  //refreshNotes();
                },
                child: NoteCard(
                  note: note,
                  index: index,
                ),
              );
            }),
      );
}

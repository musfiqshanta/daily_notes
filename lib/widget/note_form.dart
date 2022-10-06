import 'package:flutter/material.dart';

class Noteform extends StatefulWidget {
  final String? title;
  final String? description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const Noteform({
    Key? key,
    this.title = "",
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  _NoteformState createState() => _NoteformState();
}

class _NoteformState extends State<Noteform> {
  bool x = true;
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: widget.title,
          style: TextStyle(color: Colors.white54),
          //initialValue: widget.description,
          decoration: InputDecoration(
              hintText: "Title",
              fillColor: Colors.red,
              hintStyle: TextStyle(color: Colors.white70)),
          onChanged: widget.onChangedTitle,
        ),
        TextFormField(
          initialValue: widget.description,
          minLines: 4,
          maxLines: null,
          style: TextStyle(color: Colors.white54),
          decoration: InputDecoration(
              hintText: "Type Something....",
              hintStyle: TextStyle(color: Colors.white70)),
          onChanged: widget.onChangedDescription,
        )
      ],
    );
  }
}

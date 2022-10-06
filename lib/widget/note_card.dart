import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/model/note.dart';

final colors = [
  Color(0xfffeca57),
  Color(0xff1dd1a1),
  Color(0xfff368e0),
  Color(0xffff9f43),
  Color(0xff0abde3),
  Color(0xff3498db),
  Color(0xff01a3a4),
  Color(0xffA3CB38),
  Color(0xffD980FA),
];

class NoteCard extends StatelessWidget {
  final Note note;
  final int index;
  const NoteCard({Key? key, required this.note, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = colors[index % colors.length];
    final time = DateFormat.yMMMd().format(note.createdTime);
    final now = DateFormat.jm().format(note.createdTime);
    final showd = note.description.length > 60
        ? note.description.substring(0, 100)
        : note.description;
    final showt =
        note.title.length > 15 ? note.title.substring(0, 15) : note.title;

    print("Discription");
    print(showd);
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    now,
                    style: TextStyle(color: Colors.grey.shade800),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text(
                showt,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                note.description,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

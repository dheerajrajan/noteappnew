// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteappnew/model/note.dart';
import 'package:noteappnew/utils/app_color.dart';
import 'package:noteappnew/utils/text_constants.dart';
import 'package:noteappnew/view/add_notes_screen/add_notes_screen.dart';
import 'package:noteappnew/view/note_detail/note_detail.dart';

class NoteHome extends StatefulWidget {
  const NoteHome({super.key});

  @override
  State<NoteHome> createState() => _NoteHomeState();
}

class _NoteHomeState extends State<NoteHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.basicTheme,
        title: Text(
          "My Notes",
          style: AppTextTheme.appBarTextStyle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.basicTheme,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNoteScreen(),
              ));
        },
        child: Icon(
          Icons.note_alt_outlined,
          color: AppColor.headTextTheme,
          size: 30,
        ),
      ),
      body: ValueListenableBuilder<Box<Note>>(
        valueListenable: Hive.box<Note>('my_notes').listenable(),
        builder: (context, box, child) {
          List<Note> notes = box.values.toList().cast<Note>();
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              var note = notes[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.5), BlendMode.dstATop),
                          image: AssetImage(
                              "assets/animation/photo-1656066836041-e6d9f6f1eb28.avif"))),
                  child: ListTile(
                    leading: Icon(Icons.edit_note),
                    title: Text(
                      "${notes[index].title}",
                      style: AppTextTheme.bodyTextStyle,
                    ),
                    onTap: () {
                      navigateToNoteDetails(note);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void navigateToNoteDetails(Note note) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteDetails(
            note: note,
            onDelete: (p0) => null,
          ),
        ));
  }
}

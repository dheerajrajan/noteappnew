// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:noteappnew/model/note.dart';
import 'package:noteappnew/utils/app_color.dart';
import 'package:noteappnew/utils/text_constants.dart';
import 'package:noteappnew/view/add_notes_screen/add_notes_screen.dart';

class NoteDetails extends StatefulWidget {
  final Note note;
  final Function(int) onDelete;
  const NoteDetails({super.key, required this.note, required this.onDelete});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late List<bool> ischecked;
  @override
  void initState() {
    ischecked = widget.note.isCheckedList ??
        List<bool>.filled(widget.note.isCheckedList?.length ?? 0, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.basicTheme,
        title: Text(
          widget.note.title!,
          style: AppTextTheme.appBarTextStyle,
        ),
        actions: [
          IconButton(
              onPressed: () {
                navigateToEditScreen();
              },
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        children: [
          Text(
            widget.note.content!,
            style: AppTextTheme.bodyTextStyle,
          ),
          SizedBox(
            height: 15,
          ),
          if (widget.note.checkList != null &&
              widget.note.checkList!.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CheckList : ",
                  style: AppTextTheme.bodyTextStyle,
                ),
                Divider(
                  color: AppColor.contentColor,
                  thickness: 3,
                ),
                ListView.builder(
                  itemCount: widget.note.checkList!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = widget.note.checkList![index];
                    return CheckboxListTile(
                      checkColor: AppColor.contentColor,
                      activeColor: Colors.white,
                      title: Text(
                        item,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColor.headTextTheme,
                          decoration: ischecked[index]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      value: ischecked[index],
                      onChanged: (value) {
                        setState(() {
                          ischecked[index] = value!;
                        });
                      },
                    );
                  },
                )
              ],
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.basicTheme,
        onPressed: () {
          deleteNote();
        },
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  void deleteNote() {
    widget.onDelete(widget.note.id!);
  }

  void navigateToEditScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(
          note: widget.note,
        ),
      ),
    ).then((updateNote) {
      setState(() {
        widget.note.title = updateNote.title;
        widget.note.content = updateNote.content;
        widget.note.checkList = updateNote.checkList;
        widget.note.isCheckedList = updateNote.isCheckedList ?? [];
        ischecked = List<bool>.filled(widget.note.checkList!.length, false);
      });
    });
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteappnew/datadase/db.dart';
import 'package:noteappnew/model/note.dart';
import 'package:noteappnew/utils/app_color.dart';
import 'package:noteappnew/utils/snack_bar.dart';
import 'package:noteappnew/utils/text_constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key, this.note});
  final Note? note;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController addItemController = TextEditingController();
  List<String> checkListItems = [];
  List<bool> _isChecked = [];
  bool isCheckListEnabled = false;
  var formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title ?? "";
      contentController.text = widget.note!.content ?? "";
      if (widget.note!.checkList != null) {
        checkListItems.addAll(widget.note!.checkList!);
        _isChecked = List<bool>.filled(widget.note!.checkList!.length, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.basicTheme,
          title: Text(widget.note == null ? "add Your note" : "edit your note"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: AppTextTheme.bodyTextStyle,
                    ),
                    TextFormField(
                      validator: (title) {
                        if (title!.isEmpty) {
                          return "please enter a title";
                        } else {
                          return null;
                        }
                      },
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "enter your title",
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isCheckListEnabled,
                          onChanged: (value) {
                            setState(() {
                              isCheckListEnabled = value!;
                            });
                          },
                        ),
                        Text(
                          "Create Checklist",
                          style: AppTextTheme.bodyTextStyle,
                        ),
                      ],
                    ),
                    if (isCheckListEnabled == true)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                controller: addItemController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Add Item",
                                ),
                              )),
                              SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: AppColor.basicTheme,
                                child: IconButton(
                                    onPressed: () {
                                      addCheckListItem(addItemController.text);
                                      addItemController.clear();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: AppColor.headTextTheme,
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: checkListItems.length,
                      itemBuilder: (context, index) {
                        final item = checkListItems[index];
                        return ListTile(
                          title: Text(
                            item,
                            style: AppTextTheme.bodyTextStyle,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    editCheckListItem(index);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColor.headTextTheme,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    deleteCheckListItem(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColor.headTextTheme,
                                  ))
                            ],
                          ),
                        );
                      },
                    )
                  ],
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColor.contentColor,
          onPressed: () {
            var valid = formkey.currentState!.validate();
            if (valid == true) {
              String title = titleController.text;
              String content = contentController.text;
              final checklist =
                  checkListItems.isNotEmpty ? checkListItems : null;
              final checked = _isChecked.isNotEmpty ? _isChecked : null;
              final note = Note(
                  title: title,
                  content: content,
                  checkList: checklist,
                  isCheckedList: checked);
              if (widget.note == null) {
                final id = HiveDb.addNote(note);
                if (id != null) {
                  successSnackBar(context);
                  Navigator.pop(context, true);
                } else {
                  errorSnackBar(context);
                }
              } else {
                HiveDb.updateNote(widget.note!, () {});
                updateSuccessSnackBar(context);
                Navigator.pop(context, note);
              }
            } else {
              warningSnackBar(context);
            }
          },
          label: Text(
            widget.note == null ? 'Add Note' : 'Update Note',
            style: AppTextTheme.appBarTextStyle,
          ),
        ));
  }

  void addCheckListItem(String checkListItem) {
    setState(() {
      if (checkListItem.trim().isNotEmpty) {
        checkListItems.add(checkListItem.trim());
        _isChecked.add(false);
        addItemController.clear();
      }
    });
  }

  void deleteCheckListItem(int index) {
    setState(() {
      checkListItems.removeAt(index);
      setState(() {});
      _isChecked.removeAt(index);
    });
  }

  void editCheckListItem(int index) {
    String initialText = checkListItems[index];
    showDialog(
      context: context,
      builder: (context) {
        String newText = initialText;
        return AlertDialog(
          title: Text('edit checklist item'),
          content: TextField(
            controller: TextEditingController(text: initialText),
            onChanged: (value) {
              newText = value;
            },
          ),
        );
      },
    );
  }
}

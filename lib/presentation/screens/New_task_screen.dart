// ignore_for_file: must_be_immutable, file_names, unused_field, unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/main.dart';

import '../../data/models/task_model.dart';

class NewTaskScreen extends StatefulWidget {
  NewTaskScreen({Key? key, this.task}) : super(key: key);
  Task? task;
  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _taskTitle = TextEditingController(
        text: widget.task == null ? null : widget.task!.title!);
    final TextEditingController _taskNote = TextEditingController(
        text: widget.task == null ? null : widget.task!.note!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade200,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.task == null ? "New Task" : "Update your Task",
          style: GoogleFonts.quicksand(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The Title",
              style: GoogleFonts.quicksand(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _taskTitle,
              decoration: InputDecoration(
                fillColor: Colors.deepPurple.shade50.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Write Your Task's Title",
              ),
            ),
            const SizedBox(height: 40),
            Text(
              "The Note",
              style: GoogleFonts.quicksand(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 50,
              controller: _taskNote,
              decoration: InputDecoration(
                fillColor: Colors.deepPurple.shade50.withAlpha(75),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: "Write Your Task's Note",
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RawMaterialButton(
                    onPressed: () async {
                      var newTask = Task(
                        title: _taskTitle.text,
                        note: _taskNote.text,
                        creationDate: DateTime.now(),
                        done: false,
                      );
                      Box<Task> taskBox = Hive.box<Task>("tasks");
                      if (widget.task != null) {
                        widget.task!.title = newTask.title;
                        widget.task!.note = newTask.note;
                        widget.task!.save();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const HomeScreen()),
                          ),
                        );
                      } else {
                        await taskBox.add(newTask);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => const HomeScreen()),
                          ),
                        );
                      }
                    },
                    fillColor: Colors.blueGrey.shade200,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    child: Text(
                      widget.task == null ? "Add" : "Update Task",
                      style: GoogleFonts.quicksand(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

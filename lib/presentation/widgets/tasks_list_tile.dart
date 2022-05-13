// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/presentation/screens/New_task_screen.dart';

import '../../data/models/task_model.dart';

class TasksListTile extends StatefulWidget {
  TasksListTile(this.task, this.index, {Key? key}) : super(key: key);
  Task task;
  int index;

  @override
  State<TasksListTile> createState() => _TasksListTileState();
}

class _TasksListTileState extends State<TasksListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.task.title!,
                  style: GoogleFonts.ptSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => NewTaskScreen(
                            task: widget.task,
                          )),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.task.delete();
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const Divider(
            height: 20,
            color: Colors.grey,
            thickness: 1,
          ),
          Text(
            widget.task.note!,
            style: GoogleFonts.ptSans(),
          ),
        ],
      ),
    );
  }
}

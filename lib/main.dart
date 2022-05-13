// ignore_for_file: unused_local_variable

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'presentation/screens/New_task_screen.dart';
import 'presentation/widgets/custom_appbar.dart';
import 'presentation/widgets/tasks_list_tile.dart';

// ignore: todo
//TODO: Ezay ALink Elmain Box Bel HomeScreen Box?!
late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  box.add(
    Task(
      title: "This is the first task",
      note: "1-Praying For Allah. 2-Studying Hard. 3-Writing Scribt.",
      creationDate: DateTime.now(),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Hive.box<Task>("tasks").listenable(),
        builder: (
          BuildContext context,
          dynamic box,
          Widget? _,
        ) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Tasks",
                  style: GoogleFonts.quicksand(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  formatDate(DateTime.now(), [d, " ", M, " ", yyyy]),
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const Divider(
                  height: 40,
                  thickness: 3,
                  color: Colors.red,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      Task currentTask = box.getAt(index)!;
                      return TasksListTile(currentTask, index);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewTaskScreen(),
            ),
          );
        },
        backgroundColor: Colors.red,
        elevation: 4,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}

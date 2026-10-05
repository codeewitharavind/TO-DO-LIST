import 'package:flutter/material.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, dynamic>> tasks = [];

  void addTask() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add({
        'title': controller.text.trim(),
        'done': false,
      });
      controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]['done'] = !tasks[index]['done'];
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) => addTask(),
                    decoration: InputDecoration(
                      hintText: 'Enter a task...',
                      prefixIcon: const Icon(Icons.task_alt),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: addTask,
                  icon: const Icon(Icons.add),
                  color: Colors.white,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    padding: const EdgeInsets.all(15),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet!\nAdd a task to get started.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Checkbox(
                            value: task['done'],
                            onChanged: (_) => toggleTask(index),
                          ),
                          title: Text(
                            task['title'],
                            style: TextStyle(
                              fontSize: 17,
                              decoration: task['done']
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task['done'] ? Colors.grey : null,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () => deleteTask(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

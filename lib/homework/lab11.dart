import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
class StudentRegistrationUI extends StatefulWidget {
  const StudentRegistrationUI({super.key});

  @override
  studentRegistrationUIState createState() => studentRegistrationUIState();
}
class studentRegistrationUIState extends State<StudentRegistrationUI> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _deptController = TextEditingController();
  final _gradeController = TextEditingController();
  late Database _database;

  @override
  void initState() {
    super.initState();
    _opendatabase();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _gradeController.dispose();
    _deptController.dispose();
    _database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a grade';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deptController,
                decoration: const InputDecoration(
                  labelText: 'Department:',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a Department';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveStudent();
                      }
                    },
                    child: const Text('Save'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showStudents();
                    },
                    child: const Text('Show Students'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _deleteStudents();
                    },
                    child: const Text('Delete Students'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _opendatabase() async {
    _database = await openDatabase(
      'students_db.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE students (
            id INTEGER PRIMARY KEY,
            name TEXT,
            dept TEXT,
            age INTEGER,
            grade INTEGER
          )
        ''');
      },
    );
  }

  Future<void> _saveStudent() async {
    await _database.transaction((txn) async {
      await txn.rawInsert('''
          INSERT INTO students(name, age,dept, grade)
          VALUES("${_nameController.text.trim()}","${int.parse(_ageController.text.trim())}", "${_deptController.text.trim()}","${int.parse(_gradeController.text.trim())}")
        ''');
    });
    _resetFields();
    showDialoageM("Student saved successfully");
  }

  Future<void> _showStudents() async {
    final List<Map<String, dynamic>> students =
        await _database.query('students');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: const Text('Students'),
          content: Column(
            children: students.map((student) {
              return Card(
                color: const Color.fromARGB(255, 195, 205, 207),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                elevation: 2.0,
                child: ListTile(
                  title: Text(student['name']),
                  subtitle: Text(
                      'Age: ${student['age']}, Grade: ${student['grade']}, Department: ${student['dept']}'),
                  trailing: Wrap(
                    spacing: 12,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _editStudent(student);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteStudent(student['id']);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editStudent(Map<String, dynamic> student) async {
    print("--------------------------------------------");
    _nameController.text = student['name'];
    _ageController.text = student['age'].toString();
    _gradeController.text = student['grade'].toString();
    _deptController.text = student['dept'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _deptController,
                decoration: const InputDecoration(
                  labelText: 'Department',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter an Department';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _gradeController,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a grade';
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _updateStudent(student['id']);
                  _resetFields();
                  Navigator.of(context).pop();
                }
              },
            ),
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () {
                _resetFields();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateStudent(int id) async {
    await _database.rawUpdate('''
      UPDATE students
      SET name = ?,dept=?, age = ?, grade = ?
      WHERE id = ?
    ''', [
      _nameController.text,
      _deptController.text,
      int.parse(_ageController.text),
      int.parse(_gradeController.text),
      id
    ]);
    _resetFields();
    showDialoageM('Student updated successfully');
  }

  void showDialoageM(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(msg),
          actions: [
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteStudent(int id) async {
    await _database.rawDelete('DELETE FROM students WHERE id = ?', [id]);
    showDialoageM("Student deleted successfully");
  }

  Future<void> _deleteStudents() async {
    await _database.rawDelete('DELETE FROM students');
    showDialoageM('All students deleted successfully');
  }
  void _resetFields() {
    _nameController.text = '';
    _ageController.text = '';
    _gradeController.text = '';
    _deptController.text = '';
  }
}

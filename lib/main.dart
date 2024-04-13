import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(FitnessApp());
}

class Exercise {
  final String name;
  int sets;
  int reps;

  Exercise({required this.name, required this.sets, required this.reps});
}

class FitnessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData.dark(),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ExerciseSelectionScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Fitness App',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseSelectionScreen extends StatefulWidget {
  @override
  _ExerciseSelectionScreenState createState() =>
      _ExerciseSelectionScreenState();
}

class _ExerciseSelectionScreenState extends State<ExerciseSelectionScreen> {
  List<Exercise> exercises = [
    Exercise(name: 'Pushups', sets: 3, reps: 15),
    Exercise(name: 'Pullups', sets: 4, reps: 12),
    Exercise(name: 'Squats', sets: 4, reps: 10),
    Exercise(name: 'Abs', sets: 3, reps: 20),
    Exercise(name: 'Benchpress', sets: 4, reps: 12),
    Exercise(name: 'Cable Flys', sets: 3, reps: 15),
    Exercise(name: 'Lat Pulldown', sets: 4, reps: 12),
    Exercise(name: 'Rows', sets: 4, reps: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Exercise'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewDataScreen(exercises: exercises)),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Fitness App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Show Chart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProgressChartScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: exercises.map((exercise) {
            return ExerciseButton(
              exercise: exercise,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EnterDataScreen(exercise: exercise)),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ExerciseButton extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback onPressed;

  ExerciseButton({required this.exercise, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        exercise.name,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}

class EnterDataScreen extends StatefulWidget {
  final Exercise exercise;

  EnterDataScreen({required this.exercise});

  @override
  _EnterDataScreenState createState() => _EnterDataScreenState();
}

class _EnterDataScreenState extends State<EnterDataScreen> {
  late int sets;
  late int reps;

  @override
  void initState() {
    super.initState();
    sets = widget.exercise.sets;
    reps = widget.exercise.reps;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Data for ${widget.exercise.name}'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Sets'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  sets = int.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Reps'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  reps = int.parse(value);
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.exercise.sets = sets;
                widget.exercise.reps = reps;
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewDataScreen extends StatelessWidget {
  final List<Exercise> exercises;

  ViewDataScreen({required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Entered Data'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text('Sets: ${exercise.sets}, Reps: ${exercise.reps}'),
          );
        },
      ),
    );
  }
}

class ProgressChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Chart'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Display progress chart here'),
      ),
    );
  }
}

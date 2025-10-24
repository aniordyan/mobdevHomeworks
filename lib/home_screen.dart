import 'package:flutter/material.dart';
import 'grade_calculator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GradeCalculator _gradeCalculator = GradeCalculator();

  final _participationController = TextEditingController(text: '100');
  final _presentationController = TextEditingController(text: '100');
  final _midterm1Controller = TextEditingController(text: '100');
  final _midterm2Controller = TextEditingController(text: '100');
  final _finalProjectController = TextEditingController(text: '100');

  final _homeworkInputController = TextEditingController();
  
  List<double> _homeworkGrades = [];

  String _finalGradeResult = "0.00";

  @override
  void dispose() {
    _participationController.dispose();
    _presentationController.dispose();
    _midterm1Controller.dispose();
    _midterm2Controller.dispose();
    _finalProjectController.dispose();
    _homeworkInputController.dispose();
    super.dispose();
  }

  // --- Grade Calculation ---
  void _calculateFinalGrade() {
    try {
      final participation = double.parse(_participationController.text);
      final presentation = double.parse(_presentationController.text);
      final midterm1 = double.parse(_midterm1Controller.text);
      final midterm2 = double.parse(_midterm2Controller.text);
      final finalProject = double.parse(_finalProjectController.text);

      final double result = _gradeCalculator.calculateFinalGrade(
        participationAndAttendance: participation,
        groupPresentation: presentation,
        midtermExam1: midterm1,
        midtermExam2: midterm2,
        finalProject: finalProject,
        homeworkAssignments: _homeworkGrades,
      );

      setState(() {
        _finalGradeResult = result.toStringAsFixed(2);
      });
    } catch (e) {
      final errorMessage = e is ArgumentError ? e.message : "Please enter valid numbers.";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $errorMessage'),
          backgroundColor: Colors.red,
        ),
      );
      setState(() {
        _finalGradeResult = "Error";
      });
    }
  }

  // --- Homework Actions ---
  void _addHomeworkGrade() {
    // Do not allow more than 4 homework grades
    if (_homeworkGrades.length >= 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You can add a maximum of 4 homework grades.'),
          backgroundColor: Colors.red, 
      ));
      return;
    }

    final String text = _homeworkInputController.text;
    if (text.isEmpty) return;

    try {
      final double grade = double.parse(text);
      if (grade < 0 || grade > 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Grade must be between 0 and 100.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      setState(() {
        _homeworkGrades.add(grade);
      });
      _homeworkInputController.clear(); 
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Please enter a valid number.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetHomework() {
    setState(() {
      _homeworkGrades.clear();
    });
    _homeworkInputController.clear();
  }

  // --- Widgets ---
  Widget _buildGradeTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Final Grade:',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                _finalGradeResult,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              const SizedBox(height: 24),
              _buildGradeTextField(controller: _participationController, label: 'Participation (10%)'),
              _buildGradeTextField(controller: _presentationController, label: 'Group Presentation (10%)'),
              _buildGradeTextField(controller: _midterm1Controller, label: 'Midterm Exam 1 (10%)'),
              _buildGradeTextField(controller: _midterm2Controller, label: 'Midterm Exam 2 (20%)'),
              _buildGradeTextField(controller: _finalProjectController, label: 'Final Project (30%)'),
              const Divider(height: 32),
              _buildHomeworkSection(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateFinalGrade,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('CALCULATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeworkSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Homeworks (20%)', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        TextField(
          controller: _homeworkInputController,
          decoration: const InputDecoration(
            labelText: 'Enter Homework Grade',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: _resetHomework,
              child: const Text('Reset'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addHomeworkGrade,
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text('Added Homework Grades: (${_homeworkGrades.length}/4)', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(_homeworkGrades.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      'Homework ${index + 1}: ${_homeworkGrades[index]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }),
              ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../presenters/assignment_presenter.dart';

class AssignmentListScreen extends StatefulWidget {
  const AssignmentListScreen({super.key});

  @override
  State<AssignmentListScreen> createState() => _AssignmentListScreenState();
}

class _AssignmentListScreenState extends State<AssignmentListScreen> {
  final AssignmentPresenter _presenter = AssignmentPresenter();

  bool _isEditing = false;

  void _showAddAssignmentDialog() {
    String newAssignmentTitle = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Assignment'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter assignment title',
            ),
            onChanged: (value) {
              newAssignmentTitle = value;
            },
        ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Cancel Button
              child: const Text('Cancel'),
            ), // Text Button
            TextButton(
              onPressed: () {
                if (newAssignmentTitle.trim().isNotEmpty) {
                  setState(() {
                    _presenter.addAssignment(newAssignmentTitle.trim());
                  });
                }
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    ); 
  }


  void _showEditAssignmentDialog(int index) {
    final assignment = _presenter.assignments[index];
    final controller = TextEditingController(text: assignment.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Assignment'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter new title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text.trim().isNotEmpty) {
                  setState(() {
                    _presenter.updateAssignmentTitle(index, controller.text);
                    _isEditing = false;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Save'))
          ],
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    final assignments = _presenter.assignments;

    return Scaffold(
      appBar: AppBar(
      // Dynamic title based on View state
      title: Text(_isEditing ? 'Tap item to edit' : 'Assignments'),
      actions: [
        // Edit toggle button
        IconButton(
          icon: Icon(_isEditing ? Icons.close : Icons.edit),
          onPressed: () {
            setState(() {
              _isEditing = !_isEditing;
            });
          },
        ),
      ],
    ),
    body: ListView.builder(
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final assignment = assignments[index];
        return CheckboxListTile(
          title: Text(
            assignment.title,
            style: TextStyle(
              color: _isEditing ? Colors.blue : null, // Visual feedback for edit mode
            ),
          ),
          value: assignment.isCompleted,
          // 2. Delegate the decision of what tapping does based on mode
          onChanged: _isEditing
              ? (_) => _showEditAssignmentDialog(index)
              : (value) {
                  setState(() {
                    // Forward user action directly to Presenter logic
                    _presenter.toggleCompleted(index);
                  });
                },
          secondary: _isEditing ? const Icon(Icons.edit, color: Colors.blue) : null,
        );
      },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAssignmentDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
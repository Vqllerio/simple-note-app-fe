import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bloc/note_bloc.dart';
import '../../../logic/bloc/note_event.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Note')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title')),
            SizedBox(height: 10),
            TextField(
                controller: _bodyController,
                decoration: InputDecoration(labelText: 'Content')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<NoteBloc>().add(AddNoteEvent(
                      _titleController.text,
                      _bodyController.text,
                    ));
                Navigator.pop(context);
              },
              child: Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}

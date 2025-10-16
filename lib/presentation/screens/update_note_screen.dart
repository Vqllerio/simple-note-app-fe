import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bloc/note_bloc.dart';
import '../../../logic/bloc/note_event.dart';
import '../../../data/models/note_model.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Note note;

  UpdateNoteScreen({required this.note});

  @override
  _UpdateNoteScreenState createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _bodyController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note')),
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
                context.read<NoteBloc>().add(UpdateNoteEvent(
                      widget.note.id,
                      _titleController.text,
                      _bodyController.text,
                    ));
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

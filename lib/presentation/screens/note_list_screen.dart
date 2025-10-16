import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/bloc/note_bloc.dart';
import '../../../logic/bloc/note_event.dart';
import '../../../logic/bloc/note_state.dart';
import '../widgets/note_tile.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';
import '../../../data/models/note_model.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = [];
  List<Note> selectedNotes = [];
  bool isSelectionMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note List'),
        actions: [
          if (!isSelectionMode)
            IconButton(
              icon: Icon(Icons.select_all),
              onPressed: () {
                final state = context.read<NoteBloc>().state;
                if (state is NoteLoaded) {
                  setState(() {
                    isSelectionMode = true;
                    selectedNotes = List.from(state.notes);
                  });
                }
              },
            ),
          if (isSelectionMode)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context
                    .read<NoteBloc>()
                    .add(DeleteSelectedNotesEvent(selectedNotes));
                setState(() {
                  selectedNotes.clear();
                  isSelectionMode = false;
                });
              },
            ),
        ],
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            final notes = state.notes;
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteTile(
                  note: notes[index],
                  isSelectionMode: isSelectionMode,
                  isSelected: selectedNotes.contains(notes[index]),
                  onTap: () {
                    if (isSelectionMode) {
                      setState(() {
                        if (selectedNotes.contains(notes[index])) {
                          selectedNotes.remove(notes[index]);
                        } else {
                          selectedNotes.add(notes[index]);
                        }
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoteDetailScreen(note: notes[index]),
                        ),
                      );
                    }
                  },
                  onCheckboxChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedNotes.add(notes[index]);
                      } else {
                        selectedNotes.remove(notes[index]);
                      }
                    });
                  },
                );
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No notes yet.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNoteScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

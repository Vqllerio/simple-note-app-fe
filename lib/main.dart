import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repository/note_repository.dart';
import 'logic/bloc/note_bloc.dart';
import 'presentation/screens/note_list_screen.dart';
import 'logic/bloc/note_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteRepository _noteRepository = NoteRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _noteRepository,
      child: BlocProvider(
        create: (context) => NoteBloc(_noteRepository)..add(FetchNotes()),
        child: MaterialApp(
          title: 'Note Taking App',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: NoteListScreen(),
        ),
      ),
    );
  }
}

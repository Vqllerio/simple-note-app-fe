import 'package:equatable/equatable.dart';
import '../../data/models/note_model.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class FetchNotes extends NoteEvent {}

class AddNoteEvent extends NoteEvent {
  final String title;
  final String body;

  const AddNoteEvent(this.title, this.body);

  @override
  List<Object?> get props => [title, body];
}

class UpdateNoteEvent extends NoteEvent {
  final int id;
  final String title;
  final String body;

  const UpdateNoteEvent(this.id, this.title, this.body);

  @override
  List<Object?> get props => [id, title, body];
}

class DeleteSelectedNotesEvent extends NoteEvent {
  final List<Note> notes;

  const DeleteSelectedNotesEvent(this.notes);

  @override
  List<Object?> get props => [notes];
}

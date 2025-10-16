import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_event.dart';
import 'note_state.dart';
import '../../data/repository/note_repository.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository _noteRepository;

  NoteBloc(this._noteRepository) : super(NoteInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteSelectedNotesEvent>(_onDeleteSelectedNotes);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await _noteRepository.fetchNotes();
      emit(NoteLoaded(notes));
    } catch (e) {
      emit(NoteError('Failed to load notes'));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await _noteRepository.addNote(event.title, event.body);
      add(FetchNotes());
    } catch (e) {
      emit(NoteError('Failed to add note'));
    }
  }

  Future<void> _onUpdateNote(
      UpdateNoteEvent event, Emitter<NoteState> emit) async {
    try {
      await _noteRepository.updateNote(event.id, event.title, event.body);
      add(FetchNotes());
    } catch (e) {
      emit(NoteError('Failed to update note'));
    }
  }

  Future<void> _onDeleteSelectedNotes(
      DeleteSelectedNotesEvent event, Emitter<NoteState> emit) async {
    try {
      for (final note in event.notes) {
        await _noteRepository.deleteNote(note.id);
      }
      add(FetchNotes());
    } catch (e) {
      emit(NoteError('Failed to delete notes'));
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/note_model.dart';

class NoteRepository {
  final String baseUrl = 'http://localhost:8080/notes';

  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Note.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> addNote(String title, String body) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body}),
    );
    if (response.statusCode != 201) throw Exception('Failed to add note');
  }

  Future<void> updateNote(int id, String title, String body) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body}),
    );
    if (response.statusCode != 200) throw Exception('Failed to update note');
  }

  Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) throw Exception('Failed to delete note');
  }
}

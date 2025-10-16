import 'package:flutter/material.dart';
import '../../../data/models/note_model.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onTap;
  final ValueChanged<bool?> onCheckboxChanged;

  const NoteTile({
    required this.note,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onTap,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(note.title),
      subtitle: Text(note.body),
      leading: isSelectionMode
          ? Checkbox(value: isSelected, onChanged: onCheckboxChanged)
          : null,
    );
  }
}

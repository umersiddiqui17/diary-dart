import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:phase/modals/note.dart";
import "package:phase/repository/notes_repository.dart";

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final _title = TextEditingController();
  final _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
        actions: [IconButton(onPressed: insertNote, icon: Icon(Icons.done))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(
                  hintText: "Add Note",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(height: 20),
            Expanded(
              child: TextField(
                controller: _description,
                decoration: InputDecoration(
                  hintText: "Typing...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                maxLines: 15,
              ),
            )
          ],
        ),
      ),
    );
  }

  insertNote() async {
    final note = Note(
        title: _title.text,
        description: _description.text,
        createdAt: DateTime.now());
    await NoteRespository.insert(note: note);
  }
}

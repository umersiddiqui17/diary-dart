import 'package:flutter/material.dart';
import 'package:phase/repository/notes_repository.dart';
import 'package:phase/screens/Add_notescreen.dart';
import 'package:phase/widget/Itemnote.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NoteBook"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: NoteRespository.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Text("Empty"),
              );
            }
            return ListView(
              padding: EdgeInsets.all(15),
              children: [
                for (var note in snapshot.data!)
                  ItemNote(
                    note: note,
                  )
              ],
            );
          }
          return SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const AddNote()));
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
      ),
    );
  }
}

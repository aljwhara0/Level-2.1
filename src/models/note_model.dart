import 'dart:io';

class Note {
  final String title;
  final String content;

  Note({
    required this.title,
    required this.content,
  });
}

class NoteTakingApp {
  final List<Note> notes = [];

  void run() {
    print('Welcome to the Note Taking App!');

    while (true) {
      print('\nPlease select an option:');
      print('1. Create a note');
      print('2. Edit a note');
      print('3. Delete a note');
      print('4. Search for a note');
      print('5. Exit');

      var option = int.tryParse(stdin.readLineSync() ?? '');
      if (option == null || option < 1 || option > 5) {
        print('Invalid option. Please try again.');
        continue;
      }

      switch (option) {
        case 1:
          createNote();
          break;
        case 2:
          editNote();
          break;
        case 3:
          deleteNote();
          break;
        case 4:
          searchNote();
          break;
        case 5:
          exit(0);
      }
    }
  }

  void createNote() {
    print('Enter the title of the note:');
    var title = stdin.readLineSync();
    print('Enter the content of the note:');
    var content = stdin.readLineSync();

    var note = Note(
      title: title ?? '',
      content: content ?? '',
    );

    notes.add(note);
    print('Note created successfully!');
  }

  void editNote() {
    if (notes.isEmpty) {
      print('No notes available to edit.');
      return;
    }

    print('Enter the index of the note to edit:');
    printNotes();

    var index = int.tryParse(stdin.readLineSync() ?? '');
    if (index == null || index < 0 || index >= notes.length) {
      print('Invalid index. Please try again.');
      return;
    }

    print('Enter the new title of the note:');
    var newTitle = stdin.readLineSync();
    print('Enter the new content of the note:');
    var newContent = stdin.readLineSync();

    var updatedNote = Note(
      title: newTitle ?? notes[index].title,
      content: newContent ?? notes[index].content,
    );

    notes[index] = updatedNote;
    print('Note updated successfully!');
  }

  void deleteNote() {
    if (notes.isEmpty) {
      print('No notes available to delete.');
      return;
    }

    print('Enter the index of the note to delete:');
    printNotes();

    var index = int.tryParse(stdin.readLineSync() ?? '');
    if (index == null || index < 0 || index >= notes.length) {
      print('Invalid index. Please try again.');
      return;
    }

    notes.removeAt(index);
    print('Note deleted successfully!');
  }

  void searchNote() {
    print('Enter the search term (title or content):');
    var searchTerm = stdin.readLineSync();

    var searchResults = notes.where((note) =>
        note.title.contains(searchTerm ?? '') ||
        note.content.contains(searchTerm ?? ''));

    if (searchResults.isEmpty) {
      print('No matching notes found.');
    } else {
      print('Search results:');
      printNotes(searchResults.toList());
    }
  }

  void printNotes([List<Note>? noteList]) {
    final list = noteList ?? notes;
    for (var i = 0; i < list.length; i++) {
      print('$i. ${list[i].title}');
    }
  }
}


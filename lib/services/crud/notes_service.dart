import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'crud_exception.dart';


class NoteServices {
  Database? _db;

  Future<DataBaseNote> updateNote({
    required DataBaseNote note,
    required String text,
  }) async {
    final db = _getDatabseOrThrow();

    // make sure note exists
    await getNote(id: note.id);

    // update DB
    final updatesCount = await db.update(
      noteTable,
      {
        textColumn: text,
        isSyncedWithCloudColumn: 0,
      },
    );

    if (updatesCount == 0) {
      throw CouldNotUpdateNote();
    } else {
      final updatedNote = await getNote(id: note.id);
      return updatedNote;
    }
  }

  Future<Iterable<DataBaseNote>> getAllNotes() async {
    final db = _getDatabseOrThrow();
    final notes = await db.query(noteTable);

    return notes.map((noteRow) => DataBaseNote.fromRow(noteRow));
  }

  Future<DataBaseNote> getNote({required int id}) async {
    final db = _getDatabseOrThrow();
    final notes = await db.query(
      noteTable,
      limit: 1,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (notes.isEmpty) {
      throw CouldNotFindNote();
    } else {
      return DataBaseNote.fromRow(notes.first);
    }
  }

  Future<int> deleteAllNotes() async {
    final db = _getDatabseOrThrow();
    final numberOfDeletions = await db.delete(noteTable);
    return numberOfDeletions;
  }

  Future<void> deleteNote({required int id}) async {
    final db = _getDatabseOrThrow();
    final deletedCount = await db.delete(
      noteTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (deletedCount == 0) {
      throw CouldNotDeleteNote();
    } 
  }

  Future<DataBaseNote> createNote({required DataBaseUser owner}) async {
    final db = _getDatabseOrThrow();

    // make sure owner exists in the database with the correct id
    final dbUser = await getUser(email: owner.email);
    if (dbUser != owner) {
      throw CouldNotFindUser();
    }

    const text = '';
    // create the note
    final noteId = await db.insert(noteTable, {
      userIdColumn: owner.id,
      textColumn: text,
      isSyncedWithCloudColumn: 1,
    });

    final note = DataBaseNote(
      id: noteId,
      userId: owner.id,
      text: text,
      isSyncedWithCloud: true,
    );

    return note;

  }

  Future<DataBaseUser> getUser({required String email}) async {
    final db = _getDatabseOrThrow();

    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );

    if (results.isEmpty) {
      throw CouldNotFindUser();
    } else {
      return DataBaseUser.fromRow(results.first);
    }
  }

  Future<DataBaseUser> createUser ({ required String email}) async {
    final db = _getDatabseOrThrow();
    final results = await db.query(
      userTable,
      limit: 1,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (results.isNotEmpty) {
      throw UserAlreadyExists();
    }

    final userId = await db.insert(userTable, {
      emailColumn: email.toLowerCase(),
    });

    return DataBaseUser(
      id: userId,
      email: email,
    );
  }

  Future<void> deleteUser({required String email}) async {
    final db = _getDatabseOrThrow();
    final deletedCount = await db.delete(
      userTable,
      where: 'email = ?',
      whereArgs: [email.toLowerCase()],
    );
    if (deletedCount != 1) {
      throw CouldNotDeleteUser();
    }
  }

  Database _getDatabseOrThrow()
  {
    final db = _db;
    if (db == null){
      throw DatabaseIsNotOpen();
    } 
    else{
      return db;
    }
  }

  Future<void> close() async{
    final db = _db;
    if (db == null){
      throw DatabaseIsNotOpen();
    }
    else{
      await db.close();
      _db = null;
    }

  }

  Future<void> open() async{
    if(_db != null){
      throw DatabaseAlreadyOpenException();
    }
    try{
      final docsPath = await getApplicationDocumentsDirectory();
      final dbPath = join(docsPath.path, dbName);
      final db = await openDatabase(dbPath);
      _db = db;

     await db.execute(creatingUserTable);

     await db.execute(creatingNoteTable);
    

    } on MissingPlatformDirectoryException{
      throw UnableToGetDocumentsDirectory();
    }
  }


}

@immutable
class DataBaseUser{
  final int id;
  final String email;
  const DataBaseUser({required this.id, required this.email});

  DataBaseUser.fromRow(Map<String, Object?> map) : id = map[idColumn] as int, email = map[emailColumn] as String;

  @override
  String toString() => 'Person, ID = $id, email =$email';

  @override
  bool operator == (covariant DataBaseUser other) => id == other.id;
  
  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode;
  

}

class DataBaseNote{
  final int id;
  final int userId;
  final String text;
  final bool isSyncedWithCloud;

  DataBaseNote({required this.id, required this.userId, required this.text, required this.isSyncedWithCloud});
  DataBaseNote.fromRow(Map<String, Object?> map) : id = map[idColumn] as int, 
  userId = map[userIdColumn] as int,
  text = map[textColumn] as String,
  isSyncedWithCloud = (map[isSyncedWithCloudColumn] as int) == 1 ? true : false;
  
  @override
  String toString() => 'Not, ID = $id, userId =$userId, text = $text, sSyncedWithCloud = $isSyncedWithCloud ';

  @override
  bool operator == (covariant DataBaseNote other) => id == other.id;
  
  @override
  int get hashCode => id.hashCode;


}

const dbName = 'testing.db';
const noteTable = 'note';
const userTable = 'user'; 
const idColumn = 'id';
const emailColumn = 'email';
const userIdColumn = 'user_id';
const textColumn = 'text';
const isSyncedWithCloudColumn = 'is_synced_with_cloud';
const creatingUserTable = ''' CREATE TABLE IF NOT EXISTS "user" (
	"id"	INTEGER NOT NULL,
	"email"	TEXT NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);''';
const creatingNoteTable = '''
      CREATE TABLE IF NOT EXISTS"note" (
	"id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	"Text"	TEXT,
	"is_synced_with_cloud"	INTEGER NOT NULL DEFAULT 0,
	PRIMARY KEY("id" AUTOINCREMENT)
); ''';
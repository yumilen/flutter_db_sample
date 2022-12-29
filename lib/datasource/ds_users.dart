import 'package:sqflite/sqflite.dart';
import 'package:test_db/database/users_table.dart' as users;
import 'package:test_db/model/user.dart';


class UsersDatasource {
  final Database db;

  const UsersDatasource(this.db);


  Future<List<User>> getUsers() async {
    final result = await db.query(users.tableName);
    if (result.isEmpty) {
      return [];
    }
    return result.map((it) => User.fromMap(it)).toList();
  }

  Future<int> addUser(User user) async {
    return db.insert(users.tableName, user.toMap());
    //db.rawInsert('INSERT INTO my_table(name, age) VALUES("Alex", 22)');
  }

  Future<int> editUser(User user) async {
    return await db.update(
      users.tableName, 
      user.toMap(),
      where: 'id = ${user.id}',
      // whereArgs: [student.id]
    );
  }

  Future<int> deleteUser(User user) async {
    return await db.delete(
      users.tableName, 
      where: '${users.columnId} = ?',
      whereArgs: [user.id]
    );
  }

  Future<void> cleanAllUsers() async {
    await db.transaction((transaction) async {
      //await transaction.rawQuery('...');
      await transaction.delete(users.tableName);
      // where: ...
    });
  }
}

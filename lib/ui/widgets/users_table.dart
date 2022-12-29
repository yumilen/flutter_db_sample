import 'package:flutter/material.dart';
import 'package:test_db/model/user.dart';
import 'package:test_db/ui/user_details_screen.dart';


class UsersTable extends StatelessWidget {
  final List<User> users;

  const UsersTable({required this.users, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      // controller: controller,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: const [
            DataColumn(label: Text("Ім'я")),
            DataColumn(label: Text("Прізвище")),
            DataColumn(label: Text("Вік")),
            // DataColumn(label: Text("Видалити")),
          ],
          rows: users.map((user) => DataRow(
            cells: [
              DataCell(Text(user.firstName),
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => UserDetailsScreen(user: user)
                  ));
                })
              ),
              DataCell(Text(user.lastName)),
              DataCell(Text(user.age.toString())),
            /*     
              DataCell(
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: (() {
                      _db.deleteStudent(student.id);
                      _updateStudentList();
                    }))
                ) 
            */
            ]
          )).toList(),
        ),
      ),
    );
  }
}
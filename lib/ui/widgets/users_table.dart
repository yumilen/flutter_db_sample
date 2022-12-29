import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';
import 'package:test_db/ui/user_details_screen.dart';


class UsersTable extends StatefulWidget {
  const UsersTable({Key? key}) : super(key: key);

  @override
  State<UsersTable> createState() => _UsersTableState();
}

class _UsersTableState extends State<UsersTable> {
  final _bloc = UsersBloc();

  @override
  void initState() {
    super.initState();
    _bloc.add(LoadUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is UsersLoadedState) {
          final users = state.users;

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Ім'я")),
                  DataColumn(label: Text("Прізвище")),
                  DataColumn(label: Text("Вік")),
                ],
                rows: users.map((user) => DataRow(cells: [
                  DataCell(Text(user.firstName), 
                    onTap: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => UserDetailsScreen(user: user)
                      ));
                      _bloc.add(LoadUsersEvent());
                    }
                  ),
                  DataCell(Text(user.lastName)),
                  DataCell(Text(user.age.toString())),
                ])).toList(),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

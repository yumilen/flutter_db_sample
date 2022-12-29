import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';

import 'package:test_db/model/user.dart';
import 'package:test_db/ui/user_form_screen.dart';
import 'package:test_db/ui/widgets/users_table.dart';


class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final bloc = UsersBloc();

  @override
  void initState() {
    super.initState();
    print('initState');
    // _addTestValues();
    _printUsers();
  }

  void _addTestValues() {
    // final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(LoadUsersEvent());
    bloc.add(
      AddUserEvent(
        User(firstName: 'John', lastName: 'Doe', birthDate: DateTime(2000, 20, 12)),
      ),
    );
    bloc.add(
      AddUserEvent(
        User(firstName: 'Ben', lastName: 'Wallas', birthDate: DateTime(1986, 4, 3)),
      ),
    );
    bloc.add(
      AddUserEvent(
        User(firstName: 'Carl', lastName: 'Mall', birthDate: DateTime(1998, 3, 7)),
      ),
    );
  }

  void _printUsers() {
    // final bloc = BlocProvider.of<UsersBloc>(context);
    bloc.add(LoadUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Список користувачів'),
          centerTitle: true,
        ),
        body: BlocConsumer<UsersBloc, UsersState>(
          listener: (context, state) {
            if (state is UsersLoadedState) {
              print('UsersScreen Listener: ${state.users}\r\n');
            }
          },
          builder: (context, state) {
            print('UsersScreen Builder: ');
            
            if (state is UsersLoadedState) {
              print('${state.users}\r\n');
              return UsersTable(users: state.users);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const UserFormScreen()));
          },
        ),
      ),
    );
  }
}

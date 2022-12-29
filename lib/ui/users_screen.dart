import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/bloc.dart';

import 'package:test_db/ui/user_form_screen.dart';
import 'package:test_db/ui/widgets/users_table.dart';


class UsersScreen extends StatelessWidget {
  
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Список користувачів'),
          centerTitle: true,
        ),
        body: const UsersTable(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const UserFormScreen())
            );
          },
        ),
      ),
    );
  }
}

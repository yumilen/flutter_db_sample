import 'package:flutter/material.dart';
import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';

import 'package:test_db/model/user.dart';

import 'package:test_db/ui/user_form_screen.dart';
import 'package:test_db/ui/widgets/actions/edit_action.dart';


class UserDetailsScreen extends StatefulWidget {
  final User user;

  const UserDetailsScreen({required this.user, Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late final User _user;
  final _bloc = UsersBloc();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Деталі користувача'),
        centerTitle: true,
        actions: [
          EditAction(onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => UserFormScreen(user: widget.user)
            ));
            // _bloc.add(LoadUsersEvent());
            setState(() {});
          },)
        ],
      ),
      body: _UserDetailsList(user: _user),
    );
  }
}


class _UserDetailsList extends StatelessWidget {
  final User user;

  const _UserDetailsList({required this.user, super.key});


  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(user.firstName),
          subtitle: const Text("Ім'я"),
        ),
        ListTile(
          title: Text(user.lastName),
          subtitle: const Text('Прізвище'),
        ),
        ListTile(
          title: Text(user.formattedBirthDate),
          subtitle: const Text("Дата народження"),
        ),
        ListTile(
          title: Text(user.formattedAge),
          subtitle: const Text("Вік"),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'package:test_db/bloc/bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/model/user.dart';
import 'package:test_db/database/users_table.dart' as users;

import 'package:test_db/ui/users_screen.dart';
import 'package:test_db/ui/widgets/actions/delete_action.dart';
import 'package:test_db/ui/widgets/actions/save_action.dart';

import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';


class UserFormScreen extends StatefulWidget {
  final User? user;
  
  const UserFormScreen({this.user, super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _bloc = UsersBloc();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _ctrls = {
    users.columnFirstName: TextEditingController(),
    users.columnLastName: TextEditingController(),
    users.columnBirthDate: TextEditingController()
  };
  final Map<String, FocusNode> _focuses = {
    users.columnFirstName: FocusNode(),
    users.columnLastName: FocusNode(),
    users.columnBirthDate: FocusNode()
  };
  late final bool _isUpdate;
  late final User _user;
  final Map<String, dynamic> _newUserMap = {};

  @override
  void initState() {
    super.initState();

    if (widget.user != null) {
      _isUpdate = true;
      _user = widget.user as User;
      _ctrls[users.columnFirstName]?.text = _user.firstName;
      _ctrls[users.columnLastName]?.text = _user.lastName;
      _ctrls[users.columnBirthDate]?.text = _user.formattedBirthDate;
    } else {
      _isUpdate = false;
    }
  }

  @override
  void dispose() {
    _ctrls.forEach((key, value) => value.dispose());
    _focuses.forEach((key, value) => value.dispose());
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdate ? 'Редагування користувача' : 'Новий користувач'),
        centerTitle: true,
        actions: [(_isUpdate)
          ? DeleteAction(onPressed: () {
              _bloc.add(DeleteUserEvent(widget.user as User));
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const UsersScreen()));
            })
          : SaveAction(onPressed: () {
              _submitForm();
            })
        ],
      ),
      body: Form(
        key: _formStateKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            const SizedBox(height: 21.0),
            TextFormField(
              controller: _ctrls[users.columnFirstName],
              decoration: const InputDecoration(
                labelText: "Ім'я *",
                icon: Icon(Icons.person)
              ),
              validator: _validateName,
              onChanged: ((value) => _newUserMap[users.columnFirstName] = value),
              onSaved: ((newValue) => _newUserMap[users.columnFirstName] = newValue),
            ),

            const SizedBox(height: 21.0),
            TextFormField(
              controller: _ctrls[users.columnLastName],
              decoration: const InputDecoration(
                labelText: "Прізвище *",
                icon: Icon(Icons.person)
              ),
              validator: _validateName,
              onChanged: ((value) => _newUserMap[users.columnLastName] = value),
              onSaved: ((newValue) => _newUserMap[users.columnLastName] = newValue),
            ),

            const SizedBox(height: 27.0),
            DateTimeFormField(
              decoration: const InputDecoration(
                labelText: 'Дата народження *',
                // hintStyle: TextStyle(color: Colors.black45),
                // errorStyle: TextStyle(color: Colors.redAccent),
                icon: Icon(Icons.calendar_month),
              ),
              mode: DateTimeFieldPickerMode.date,
              dateFormat: DateFormat('dd.MM.y'),
              initialValue: _user.birthDate,
              lastDate: DateTime.now(),
              // initialDate: widget.user?.birthDate,
              // autovalidateMode: AutovalidateMode.always,
              validator: _validateDate,
              onDateSelected: (DateTime value) {
                print('onDateSelected: $value');
                _newUserMap[users.columnBirthDate] = value;
              },
              onSaved: (DateTime? newValue) {
                print('onSaved: $newValue');
                _newUserMap[users.columnBirthDate] = newValue;
              }
            ),
          ],
        ),
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full Name is Requires!';
    } 

    // Check with RegExp
    var nameExp = RegExp(r'^[А-Яа-яІіЇїA-Za-z]+$');
    var expRes = nameExp.hasMatch(value);
    print('RegExp Result: $expRes');
    if (!expRes) {
      return 'Please enter alphabetical characters';
    }

    return null;
  }

  String? _validateDate(DateTime? value) {
    if (value == null) {
      return "Будь-ласка, введіть Дату народження";
    }
    return null;
  }

   void _changeFocus(BuildContext context, FocusNode? currentFocus, FocusNode? nextFocus) {
    if (currentFocus == null || nextFocus == null) return;

    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _submitForm() {
    if (_formStateKey.currentState!.validate()) {
      print('Form is Valid!');

      _formStateKey.currentState?.save();

      print('_newUserMap: $_newUserMap');
      User newUser = User.fromMap(_newUserMap);
      print(newUser);
      if (_isUpdate) {
        if (_user != newUser) {
          print(_user);
        }
      } else {
        _bloc.add(AddUserEvent(newUser));
        Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const UsersScreen()));
      }

    } else {
      print('Form not Valid!');
    }
  }
}
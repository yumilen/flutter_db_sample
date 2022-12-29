import 'package:test_db/model/user.dart';


abstract class UsersEvent {}

class LoadUsersEvent extends UsersEvent {}

class AddUserEvent extends UsersEvent {
  final User user;

  AddUserEvent(this.user);
}

class EditUserEvent extends UsersEvent {
  final User user;

  EditUserEvent(this.user);
}

class DeleteUserEvent extends UsersEvent {
  final User user;

  DeleteUserEvent(this.user);
}

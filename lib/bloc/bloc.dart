import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_db/bloc/events.dart';
import 'package:test_db/bloc/states.dart';
import 'package:test_db/database/database.dart';
import 'package:test_db/datasource/ds_users.dart';


class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitState()) {
    on<LoadUsersEvent>(onLoadUsersEvent);
    on<AddUserEvent>(onAddUserEvent);
    on<EditUserEvent>(onEditUserEvent);
    on<DeleteUserEvent>(onDeleteUserEvent);
  }


  Future<void> onLoadUsersEvent(LoadUsersEvent event, Emitter<UsersState> emit) async {
    final UsersDatasource usersDs = UsersDatasource(await provideDb());
    final users = await usersDs.getUsers();
    emit(UsersLoadedState(users));
  }

  Future<void> onAddUserEvent(AddUserEvent event, Emitter<UsersState> emit) async {
    final UsersDatasource usersDs = UsersDatasource(await provideDb());
    usersDs.addUser(event.user);
  }

  Future<void> onEditUserEvent(EditUserEvent event, Emitter<UsersState> emit) async {
    final UsersDatasource usersDs = UsersDatasource(await provideDb());
    usersDs.editUser(event.user);
    emit(UsersEditState(event.user));
  }

  Future<void> onDeleteUserEvent(DeleteUserEvent event, Emitter<UsersState> emit) async {
    final UsersDatasource usersDs = UsersDatasource(await provideDb());
    usersDs.deleteUser(event.user);
  }
}




import 'dart:convert';

import 'package:Collectioneer/domain/entities/user_entity.dart';
import 'package:crypto/crypto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/database.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppDatabase database;

  LoginCubit(this.database) : super(LoginInitial());

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    try {
      final hashedPassword = _hashPassword(password);
      final user = await database.userDao.login(username, hashedPassword);
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure('Invalid username or password'));
      }
    } catch (e) {
      emit(LoginFailure('Error: $e'));
    }
  }

  Future<void> register(String username, String password, String email) async {
    try {
      final hashedPassword = _hashPassword(password);
      final user = UserEntity(0, username, hashedPassword, email, DateTime.now().millisecondsSinceEpoch);
      await database.userDao.insertUser(user);
      emit(RegisterSuccess('User registered successfully!'));
    } catch (e) {
      emit(LoginFailure('Error: $e'));
    }
  }
}

// ignore_for_file: unused_import

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:fe/model/user.model.dart';
import 'package:fe/provider/session.provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'login.state.dart';
part 'login.event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // event handler was added
    on<LoginEvent>((event, emit) async {
      await loginUser(emit, event);
    });
  }

  loginUser(Emitter<LoginState> emit, LoginEvent event) async {
    emit(LoginLoading());
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (event is CheckLoginEvent) {
        var id = prefs.getInt("id");
        if (id != null) {
          emit(LoginSecondState());
        } else {
          emit(LoginFirstState());
        }
      } else if (event is StartLoginEvent) {
        if (event.username == "" || event.password == "") {
          emit(LoginFailure(error: "Username or password cannot be blank"));
        } else {
          var user = await SessionProvider.login(event.username, event.password);
          if (user != null) {
            prefs.setString("id", user.id ?? "");
            prefs.setString("name", user.name ?? "");
            prefs.setString("accessToken", user.accessToken ?? "");
            prefs.setString("roles", user.roles ?? "");
            prefs.setString("username", user.username ?? "");
            // await SessionProvider.postToken();
            emit(LoginSuccessState(userModel: user));
          } else {
            emit(LoginFailure(error: "Username or password is incorrect"));
          }
        }
      }
    } catch (e) {
      print("Loi: $e");
      emit(LoginFailure(error: "Username or password is incorrect"));
    }
  }
}

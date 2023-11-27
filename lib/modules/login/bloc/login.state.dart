// ignore_for_file: prefer_const_constructors_in_immutables

part of 'login.bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

//Đăng nhập lần đầu
class LoginFirstState extends LoginState {}

//Đã từng đăng nhập phiên trước
class LoginSecondState extends LoginState {
  LoginSecondState();
}

class LoginSuccessState extends LoginState {
  final UserModel userModel;
  LoginSuccessState({required this.userModel});
  @override
  List<Object> get props => [userModel];
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}

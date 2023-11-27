// ignore_for_file: use_build_context_synchronously, prefer_const_constructors
import 'package:fe/app/widgets/border_textfield.dart';
import 'package:fe/app/widgets/loading.dart';
import 'package:fe/app/widgets/toast.dart';
import 'package:fe/app/widgets/will.pop.scope.dart';
import 'package:fe/modules/listclass/listclass.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login.bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkLogin = true;
  final _bloc = LoginBloc();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    // _bloc.add(CheckLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPS(
      child: Scaffold(
        body: BlocConsumer<LoginBloc, LoginState>(
            bloc: _bloc,
            listener: (context, state) async {
              if (state is LoginLoading) {
                onLoading(context);
                return;
              } else if (state is LoginSecondState) {
                Navigator.pop(context);
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ListClassScreen(
                      isTeacher: true,
                    ),
                  ),
                );
              } else if (state is LoginFirstState) {
                Navigator.pop(context);
                checkLogin = true;
              } else if (state is LoginSuccessState) {
                Navigator.pop(context);
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ListClassScreen(
                      isTeacher: state.userModel.roles != "SINHVIEN",
                    ),
                  ),
                );
              } else if (state is LoginFailure) {
                showToast(
                  context: context,
                  msg: state.error,
                  color: Colors.orange,
                  icon: const Icon(Icons.warning),
                );
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return checkLogin
                  ? Container(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 100, bottom: 50),
                              height: 200,
                              child: Image.asset(
                                "assets/logo.jpeg",
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 15),
                            BorderTextField(
                              controller: usernameController,
                              title: "Username",
                              placeholder: 'Enter your username',
                              onChangeText: (value) {
                                username = value;
                              },
                            ),
                            const SizedBox(height: 15),
                            BorderTextField(
                              controller: passwordController,
                              title: "Password",
                              placeholder: 'Enter your password',
                              isPassword: true,
                              onChangeText: (value) {
                                password = value;
                              },
                            ),
                            const SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.only(top: 15),
                              height: 56,
                              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () async {
                                        _bloc.add(StartLoginEvent(username: username, password: password));
                                      },
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 100, bottom: 50),
                            height: 200,
                            child: Image.asset(
                              "assets/logo.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    );
            }),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}

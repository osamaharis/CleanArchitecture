import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Features/auth/Logout/Presentation/bloc/logout_bloc.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';
import 'package:project_cleanarchiteture/Utils/Routing.dart';
import 'package:project_cleanarchiteture/WidgetComponents/CutomButton.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> with LocalData {
  late String newDeviceId;

  @override
  void initState() {
    getToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutFailureState) {
          print('on screen: submission failure');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.replaceAll('Exception:', '')),
              backgroundColor: Colors.red,
            ),
          );
        }
        if (state is LogoutSuccessState) {
          print('on screen: success');

          context.pushReplacement(SIGNIN);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Logged out"),
            ),
          );
        }
      },
      builder: (context, state) {
        return _LogoutButton();
      },
    );
  }

  Widget _LogoutButton() {
    return BlocBuilder<LogoutBloc, LogoutState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CustomButton(
            color: Colors.blue,
            title: state is LogoutLoadingState
                ? const Center(child: CircularProgressIndicator())
                : const Text(
                    'Logout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            onClick: () async {
              await getUserinfo(USER_INFO);

              String? userDataJson = savedLoginData;

              print(jsonDecode(userDataJson!));

              print(LoginAdmin.fromJson(jsonDecode(userDataJson)));

              LoginAdmin userData =
                  LoginAdmin.fromJson(jsonDecode(userDataJson));

              String deviceId = newDeviceId;
              String token = userData.token;

              print("device id: $deviceId");
              print("token: $token");

              state is! LogoutLoadingState
                  ? context.read<LogoutBloc>().add(
                        LogoutButtonPressed(
                          deviceId: deviceId,
                          token: token,
                        ),
                      )
                  : null;
            },
          ),
        );
      },
    );
  }

  Future<String> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        newDeviceId = token!;
        print("Token deviceId: $newDeviceId");
      });
    });
    return newDeviceId;
  }
}

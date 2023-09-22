import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';
import 'package:project_cleanarchiteture/Utils/Routing.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);
  var storage = LocalData();

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin, LocalData {
  @override
  void initState() {
    super.initState();
    loadDataAndNavigate();
  }

  void loadDataAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    await getUserinfo(USER_INFO);

    if (savedLoginData == null) {
      context.go(SIGNIN);
    } else {
      context.go('/user');
    }
    //context.go(USER);
  }

  @override
  Widget build(BuildContext context) {
    // loadDataAndNavigate();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(height: 80),
            Expanded(
              child: Lottie.asset(
                'assets/animationSplash.json',
                height: 200,
                width: 200,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                await getUserinfo(USER_INFO);

                if (savedLoginData == null) {
                  context.go(SIGNIN);
                } else {
                  context.go('/user');
                }

                // context.go('/user');

                // context.go(SIGNIN);
                // loadDataAndNavigate();
              },
              child: const Text("Skip"),
            ),
          ],
        ),
      ),
    );
  }
}

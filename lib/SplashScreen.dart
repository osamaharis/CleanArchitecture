import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';
import 'package:project_cleanarchiteture/Utils/Routing.dart';

class SplashView extends StatefulWidget {
   SplashView({Key? key}) : super(key: key);
var storage= LocalData();
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    loadDataAndNavigate();
  }

  void loadDataAndNavigate()  {
    Future.delayed( Duration(milliseconds: 3));
    if(widget.storage.getUserinfo(USER_INFO) == null)
      {
    context.go(SIGNIN);
      }
    else {
      context.go(USER);
    }
    //context.go(USER);
  }

  @override
  Widget build(BuildContext context) {
    // GoToMain();
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
              onPressed: () {
                context.go(SIGNIN);

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

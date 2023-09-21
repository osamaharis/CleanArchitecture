import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/userscreens/user.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/presentation/screens/ForgetPasswordScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/params/UserLoginInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Presentation/bloc/login_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Presentation/screens/HomeScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Presentation/screens/SignupScreen.dart';
import 'package:http/http.dart' as http;
import 'package:project_cleanarchiteture/Utils/Routing.dart';
import 'package:project_cleanarchiteture/Utils/TextResources.dart';

import '../../../../../Core/Notifications_Services.dart';

// class LoginFromWidget extends StatelessWidget {
//   const LoginFromWidget({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => LoginBloc(
//           loginRepo: LoginRepositoryImple(
//               remotedatasources: LoginRemoteDatasourceImpl())),
//       child: LoginFrom(
//         loginBloc: LoginBloc(
//             loginRepo: LoginRepositoryImple(
//                 remotedatasources: LoginRemoteDatasourceImpl())),
//       ),
//     );
//   }
// }

class LoginFrom extends StatefulWidget {
  LoginFrom({super.key, required this.loginBloc});

  final LoginBloc loginBloc;
  NotificationServices services = NotificationServices();

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;

  bool isObscure = true;
  final _key = GlobalKey<FormState>();
  String errorMessage = "";
  var newtoken = "";
  var ipAddress = "";

  late AnimationController _controller;
  double _offset = 0.0;
  double initailHeight = 10.0;

  void _startAnimationPencil() {
    if (!_controller.isAnimating) {
      _controller.forward(from: 0.0);
    }
  }

  void _stopAnimationPencil() {
    if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  void _startAnimationShhh() {
    setState(() {
      initailHeight = 80;
    });
  }

  void _stopAnimationShhh() {
    setState(() {
      initailHeight = 10.0;
    });
  }

  Future<void> sizeChange() async {
    await Future.delayed(const Duration(milliseconds: 700));
    setState(() {
      initailHeight = 80;
    });
  }

  Future<String> fetchPublicIP() async {
    final response =
        await http.get(Uri.parse('https://api.ipify.org?format=json'));

    if (response.statusCode == 200) {
      final address = jsonDecode(response.body)['ip'];
      ipAddress = address;
      print("IP Address: $ipAddress");

      return ipAddress;
    } else {
      print("Failed to fetch public IP");
      throw Exception('Failed to fetch public IP');
    }
  }

  //

  @override
  void initState() {
    widget.services.requestnotificationpermission();
    widget.services.Devicetoken().then((value) {
      print(value);
      newtoken = value;
    });
    // getToken();
    fetchPublicIP();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {
          _offset = _controller.value * 50.0;
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
          errorMessage =
              state.error.replaceAll("Exception:", "").trim().toString();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is LoginSuccessState) {
          context.pushReplacement(USER);
        }
      },
      builder: (context, state) {
        return Form(
          key: _key,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  if (errorMessage.isNotEmpty)
                    Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/paper.png',
                        width: 210,
                        height: 210,
                      ),
                      Positioned(
                        top: 32,
                        left: 67,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceOut,
                          height: initailHeight,
                          child: isObscure
                              ? const SizedBox()
                              : Image.asset(
                                  'assets/shhhh.png',
                                  width: 80,
                                  height: 80,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 2,
                        right: 48,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(_offset, 0, 0),
                          child: Image.asset(
                            'assets/pencil.png',
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Sign in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 68,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null) return "Enter Email";
                      if (value.isEmpty ||
                          !RegExp(
                            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
                          ).hasMatch(value)) {
                        return "Enter Email correctly";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        _startAnimationPencil();
                      } else {
                        _stopAnimationPencil();
                      }
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty
                          // ||
                          //     !RegExp(
                          //       r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
                          //     ).hasMatch(value)
                          ) {
                        return "Enter Password correctly";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        _startAnimationPencil();
                      } else {
                        _stopAnimationPencil();
                      }
                    },
                    obscureText: isObscure,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                            if (!isObscure) {
                              _startAnimationShhh();
                            } else {
                              _stopAnimationShhh();
                            }
                            // sizeChange();
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _LoginButton(
                    input: UserLoginInput(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                      deviceId: newtoken,
                      loginIp: ipAddress,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      context.push(FORGET_PASSWORD);
                    },
                    child: const Text(txtforgetpassword),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(donthaveaccount),
                      TextButton(
                        onPressed: () {
                          context.push(SIGNUP);
                        },
                        child: const Text(txt_signup),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final loginBloc = BlocProvider.of<LoginBloc>(context);
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('Login'),
  //     ),
  //     body: BlocListener<LoginBloc, LoginState>(
  //       listener: (context, state) {
  //         if (state is LoginSuccessState) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const HomeScreen(),
  //             ),
  //           );
  //         } else if (state is LoginFailureState) {
  //           // Handle login failure, show an error message, etc.
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text(state.error),
  //               duration: Duration(seconds: 3),
  //             ),
  //           );
  //         }
  //       },
  //       child: BlocBuilder<LoginBloc, LoginState>(
  //         builder: (context, state) {
  //           return Padding(
  //             padding: const EdgeInsets.all(16.0),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 TextField(
  //                   controller: emailController,
  //                   decoration: InputDecoration(labelText: 'Email'),
  //                 ),
  //                 TextField(
  //                   controller: passwordController,
  //                   obscureText: true,
  //                   decoration: InputDecoration(labelText: 'Password'),
  //                 ),
  //                 SizedBox(height: 20),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     final input = UserLoginInput(
  //                       email: emailController.text,
  //                       password: passwordController.text,
  //                       deviceId: newtoken,
  //                       loginIp: ipAddress,
  //                     );
  //                     loginBloc.add(LoginButtonPressed(input: input));
  //                   },
  //                   child: Text('Login'),
  //                 ),
  //                 if (state is LoginLoadingState) CircularProgressIndicator(),
  //               ],
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<LoginBloc, LoginState>(
  //     bloc: _loginBloc,
  //     builder: (context, state) {
  //       if (state is LoginInitialState) {
  //         return Form(
  //           key: _key,
  //           child: SingleChildScrollView(
  //             child: Padding(
  //               padding: const EdgeInsets.all(12.0),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                 // ignore: prefer_const_literals_to_create_immutables
  //                 children: [
  //                   Stack(
  //                     children: [
  //                       Image.asset(
  //                         'assets/paper.png',
  //                         width: 210,
  //                         height: 210,
  //                       ),
  //                       Positioned(
  //                         top: 32,
  //                         left: 67,
  //                         child: AnimatedContainer(
  //                           duration: const Duration(milliseconds: 300),
  //                           curve: Curves.bounceOut,
  //                           height: initailHeight,
  //                           child: isObscure
  //                               ? const SizedBox()
  //                               : Image.asset(
  //                                   'assets/shhhh.png',
  //                                   width: 80,
  //                                   height: 80,
  //                                 ),
  //                         ),
  //                       ),
  //                       Positioned(
  //                         bottom: 2,
  //                         right: 48,
  //                         child: AnimatedContainer(
  //                           duration: const Duration(milliseconds: 300),
  //                           transform: Matrix4.translationValues(_offset, 0, 0),
  //                           child: Image.asset(
  //                             'assets/pencil.png',
  //                             width: 100,
  //                             height: 100,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   // Image.asset(
  //                   //   "assets/login.png",
  //                   //   width: 200,
  //                   //   height: 200,
  //                   // ),
  //                   const Text(
  //                     "Sign In",
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 68,
  //                     ),
  //                   ),
  //                   const SizedBox(height: 30),
  //                   TextFormField(
  //                     keyboardType: TextInputType.emailAddress,
  //                     validator: (value) {
  //                       if (value == null) return "Enter Email";
  //                       if (value.isEmpty ||
  //                           !RegExp(
  //                             r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  //                           ).hasMatch(value)) {
  //                         return "Enter Email correctly";
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                     onChanged: (text) {
  //                       if (text.isNotEmpty) {
  //                         _startAnimationPencil();
  //                       } else {
  //                         _stopAnimationPencil();
  //                       }
  //                     },
  //                     controller: emailController,
  //                     decoration: const InputDecoration(
  //                       labelText: 'Email',
  //                     ),
  //                   ),
  //                   TextFormField(
  //                     validator: (value) {
  //                       if (value!.isEmpty ||
  //                           !RegExp(
  //                             r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  //                           ).hasMatch(value)) {
  //                         return "Enter Password correctly";
  //                       } else {
  //                         return null;
  //                       }
  //                     },
  //                     onChanged: (text) {
  //                       if (text.isNotEmpty) {
  //                         _startAnimationPencil();
  //                       } else {
  //                         _stopAnimationPencil();
  //                       }
  //                     },
  //                     obscureText: isObscure,
  //                     controller: passwordController,
  //                     decoration: InputDecoration(
  //                       labelText: 'Password',
  //                       suffixIcon: IconButton(
  //                         icon: Icon(
  //                           isObscure ? Icons.visibility : Icons.visibility_off,
  //                         ),
  //                         onPressed: () {
  //                           setState(() {
  //                             isObscure = !isObscure;
  //                             if (!isObscure) {
  //                               _startAnimationShhh();
  //                             } else {
  //                               _stopAnimationShhh();
  //                             }
  //                             // sizeChange();
  //                           });
  //                         },
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 20),

  //                   ElevatedButton(
  //                     onPressed: () {
  //                       state is! LoginLoadingState ? submitButton() : null;
  //                       // state is! LoginLoadingState
  //                       //     ?
  //                       // context.read<LoginBloc>().add(
  //                       //       LoginButtonPressed(
  //                       //         input: UserLoginInput(
  //                       //           email: emailController.text,
  //                       //           password: passwordController.text,
  //                       //           deviceId: newtoken,
  //                       //           loginIp: ipAddress,
  //                       //         ),
  //                       //       ),
  //                       //     );
  //                       // : null;
  //                       // print("State: $state");

  //                       // state is LoginLoadingState
  //                       //     ? const CircularProgressIndicator()
  //                       //     : null;
  //                       // state is LoginSuccessState
  //                       //     ? Navigator.push(
  //                       //         context,
  //                       //         MaterialPageRoute(
  //                       //           builder: (context) => const HomeScreen(),
  //                       //         ),
  //                       //       )
  //                       //     : null;
  //                       // print("State 2: $state");

  //                       // state is LoginFailureState
  //                       //     ? ScaffoldMessenger.of(context).showSnackBar(
  //                       //         const SnackBar(
  //                       //           content: Text("error"),
  //                       //           // backgroundColor: Colors.red,
  //                       //         ),
  //                       //       )
  //                       //     : null;

  //                       // if (state is! LoginLoadingState) {
  //                       // context.read<LoginBloc>().add(
  //                       //       LoginButtonPressed(
  //                       //         input: UserLoginInput(
  //                       //           email: emailController.text,
  //                       //           password: passwordController.text,
  //                       //           deviceId: newtoken,
  //                       //           loginIp: ipAddress,
  //                       //         ),
  //                       //       ),
  //                       //     );
  //                       // print("state1: $state");
  //                       // }
  //                       // if (state is LoginSuccessState) {
  //                       //   print("state2: $state");

  //                       //   Navigator.push(
  //                       //     context,
  //                       //     MaterialPageRoute(
  //                       //       builder: (context) => const HomeScreen(),
  //                       //     ),
  //                       //   );
  //                       // } else if (state is LoginFailureState) {
  //                       //   print("state3: $state");
  //                       //   ScaffoldMessenger.of(context).showSnackBar(
  //                       //     const SnackBar(
  //                       //       content: Text("error"),
  //                       //       // backgroundColor: Colors.red,
  //                       //     ),
  //                       //   );
  //                       // }

  //                       // print(state);
  //                       // ScaffoldMessenger.of(context).showSnackBar(
  //                       //   const SnackBar(
  //                       //     content: Text("logged in"
  //                       //         // state.message,
  //                       //         ),
  //                       //     // backgroundColor: Colors.red,
  //                       //   ),
  //                       // );

  //                       // Navigator.push(
  //                       //   context,
  //                       //   MaterialPageRoute(
  //                       //     builder: (context) => const HomeScreen(),
  //                       //   ),
  //                       // );
  //                     },
  //                     child:
  //                         //  state is LoginLoadingState
  //                         //     ? const CircularProgressIndicator()
  //                         //     :
  //                         const Text("Login"),
  //                   ),
  //                   const SizedBox(height: 20),

  //                   TextButton(
  //                     onPressed: () {
  //                       // context.push(FORGET_PASSWORD);
  //                       // Navigator.push(
  //                       //   context,
  //                       //   MaterialPageRoute(
  //                       //     builder: (context) {
  //                       //       return ForgetPasswordView();
  //                       //     },
  //                       //   ),
  //                       // );
  //                     },
  //                     child: const Text("Forget Password?"),
  //                   ),
  //                   const SizedBox(height: 20),

  //                   Row(
  //                     children: [
  //                       const Text("Don't Have an Account?"),
  //                       TextButton(
  //                         onPressed: () {
  //                           // Navigator.pop(context);
  //                           // context.push(SIGNUP);
  //                           // Navigator.push(
  //                           //   context,
  //                           //   MaterialPageRoute(
  //                           //     builder: (context) {
  //                           //       return SignUpView();
  //                           //     },
  //                           //   ),
  //                           // );
  //                         },
  //                         child: const Text("Sign Up"),
  //                       )
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       } else if (state is LoginLoadingState) {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       } else if (state is LoginFailureState) {
  //         return Text("Enter fields");
  //         // _onWidgetDidBuild(
  //         //   () {
  //         //     ScaffoldMessenger.of(context).showSnackBar(
  //         //       SnackBar(
  //         //         content: Text(
  //         //           state.error,
  //         //         ),
  //         //         backgroundColor: Colors.red,
  //         //       ),
  //         //     );
  //         //   },
  //         // );
  //       } else if (state is LoginSuccessState) {
  //         _onWidgetDidBuild(
  //           () {
  //             print(state.message);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               SnackBar(
  //                 content: Text(
  //                   state.message,
  //                 ),
  //                 // backgroundColor: Colors.red,
  //               ),
  //             );

  //             Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => const HomeScreen(),
  //               ),
  //             );
  //           },
  //         );
  //       }
  //       return const SizedBox();
  //     },
  //   );
  // }

  // void _onWidgetDidBuild(Function callback) {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     callback();
  //   });
  // }

  // submitButton() {
  //   LoginButtonPressed(
  //     input: UserLoginInput(
  //       email: emailController.text,
  //       password: passwordController.text,
  //       deviceId: newtoken,
  //       loginIp: ipAddress,
  //     ),
  //   );
  // }

  // _onLoginButtonPressed() {
  //   _loginBloc.dispatch(LoginButtonPressed(
  //     username: _usernameController.text,
  //     password: _passwordController.text,
  //   ));
  // }

  Widget _LoginButton({required UserLoginInput input}) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            // disabledColor: Colors.blueAccent.withOpacity(0.6),
            // color: Colors.blueAccent,
            onPressed: () {
              if (_key.currentState!.validate()) {
                // state is LoginInitialState
                // ?
                // () =>
                context.read<LoginBloc>().add(
                      LoginButtonPressed(
                        input: input,
                      ),
                    );
                // : null,
              }
            },
            child: state is LoginLoadingState
                ? const Center(child: CircularProgressIndicator())
                : const Text(txt_login),
          ),
        );
      },
    );
  }
}



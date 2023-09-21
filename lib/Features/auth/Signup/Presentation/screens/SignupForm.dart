import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Presentation/screens/LoginScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/entities/AddressModel.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/entities/Name.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Domain/params/UserSignupInput.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Presentation/bloc/signup_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:project_cleanarchiteture/Utils/Routing.dart';

class SignupFrom extends StatefulWidget {
  const SignupFrom({super.key, required this.signupBloc});

  final SignupBloc signupBloc;

  @override
  State<SignupFrom> createState() => _SignupFromState();
}

class _SignupFromState extends State<SignupFrom>
    with SingleTickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressEnController = TextEditingController();
  TextEditingController addressArController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignupBloc get _SignupBloc => widget.signupBloc;

  bool isObscure = true;
  final _key = GlobalKey<FormState>();

  late String newtoken;
  var ipAddress;
  String errorMessage = "";
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

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String> getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        newtoken = token!;
        print("Token: $newtoken");
      });
    });
    return newtoken;
  }

  @override
  void initState() {
    requestPermission();
    getToken();
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
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupFailureState) {
          errorMessage =
              state.error;
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is SignupSuccessState) {
          context.pushReplacement(SIGNIN);
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
                    "Sign up",
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
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return "Enter Name correctly";
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
                    controller: nameEnController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name in English',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Name";
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
                    controller: nameArController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      labelText: 'الاسم الكامل بالعربية',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^(?:[+0]9)?[0-9]{10,12}$')
                              .hasMatch(value)) {
                        return "Enter Phone Number correctly";
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
                    controller: phoneNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Address";
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
                    controller: addressEnController,
                    decoration: const InputDecoration(
                      labelText: 'Address in English',
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Address";
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
                    controller: addressArController,
                    textAlign: TextAlign.right,
                    decoration: const InputDecoration(
                      labelText: 'العنوان بالعربية',
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
                    controller: passwordController,
                    obscureText: isObscure,
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
                  _SignupButton(
                    input: UserSignupInput(
                      email: emailController.text,
                      password: passwordController.text,
                      deviceId: newtoken,
                      fullName: Name(
                        en: nameEnController.text,
                        ar: nameArController.text,
                      ),
                      phoneNumber: phoneNumberController.text,
                      address: Address(
                        en: addressEnController.text,
                        ar: addressArController.text,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Already Have an Account?"),
                      TextButton(
                        onPressed: () {
                          context.pushReplacement(SIGNIN);

                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return SignInView();
                          //     },
                          //   ),
                          // );
                        },
                        child: const Text("Sign In"),
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

  Widget _SignupButton({required UserSignupInput input}) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton(
            onPressed: () {
              if (_key.currentState!.validate()) {
                context.read<SignupBloc>().add(
                      SignupButtonPressed(
                        input: input,
                      ),
                    );
                // : null,
              }
            },
            child: state is SignupLoadingState
                ? const Center(child: CircularProgressIndicator())
                : const Text('Signup'),
          ),
        );
      },
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_cleanarchiteture/Features/CRUD/bloc/user_bloc.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/roles_lov_repository.dart';
import 'package:project_cleanarchiteture/Features/CRUD/repo/users_lov_repository.dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/userscreens/user.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/data/datasources/CreateNewPasswordRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/data/repositories/CreateNewPasswordRepositoryImple.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/presentation/bloc/create_new_password_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/Data/repositories/ForgetPasswordRepositoryImple.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/data/datasources/ForgetPasswordRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/presentation/bloc/forget_password_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Data/datasource/LoginRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Data/repositories/LoginRepositoryImple.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Presentation/bloc/login_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/OTP/data/repositories/OtpRepositoryImple.dart';
import 'package:project_cleanarchiteture/Features/auth/OTP/presentation/bloc/otp_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/Otp/data/datasources/OtpRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Data/datasources/SignupRemoteDatasource.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Data/repositories/SignupRepositoryImple.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Presentation/bloc/signup_bloc.dart';
import 'package:project_cleanarchiteture/Utils/Routing.dart';
import 'package:get_it/get_it.dart';
import 'Theme/CustomTheme.dart';
import 'injection.dart' as di;

class SimpleBlocDelegate extends FlowDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(Firebasebackground);


  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsBinding.instance.addPostFrameCallback((_) {
    // executes after build
  });

  runApp(Login());
}

Future<void> Firebasebackground(RemoteMessage message) async {

    await  Firebase.initializeApp();
}


class Login extends StatelessWidget {
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<LoginBloc>(create: (context) => di.sl<LoginBloc>()),
        BlocProvider(
          create: (context) => LoginBloc(
            loginRepo: LoginRepositoryImple(
              remotedatasources: LoginRemoteDatasourceImpl(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => SignupBloc(
            signupRepo: SignupRepositoryImple(
              remotedatasources: SignupRemoteDatasourceImpl(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordBloc(
            forgetPasswordRepo: ForgetPasswordRepositoryImple(
              remotedatasources: ForgetPasswordRemoteDatasourceImpl(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => OtpBloc(
            otpRepo: OtpRepositoryImple(
              remotedatasources: OtpRemoteDatasourceImpl(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => CreateNewPasswordBloc(
            createNewPasswordRepo: CreateNewPasswordRepositoryImple(
              remotedatasources: CreateNewPasswordRemoteDatasourceImpl(),
            ),
          ),
        ),
        // BlocProvider(
        //   create: (_) => UserBloc(
        //     roleLovRepo: RoleLovRepository(),
        //     userLovRepo: UserLovRepository(),
        //   ),
        //   child:  User(),
        // ),
      ],
      child: MaterialApp.router(
        // MaterialApp(
        routerConfig: routes,
        title: 'Authentication',
        debugShowCheckedModeBanner: false,
        theme:CustomTheme().main_theme.copyWith(
          radioTheme: Theme.of(context).radioTheme,
          dividerColor: Colors.transparent,
          checkboxTheme: Theme.of(context).checkboxTheme.copyWith(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              splashRadius: 0),
        ),
        darkTheme: CustomTheme().main_theme,
        themeMode: ThemeMode.system,
        // home: SignInView(),
      ),
    );
  }
}

// class App extends StatefulWidget {
//   App({Key? key, required this.loginRepository}) : super(key: key);
//   final LoginRepository loginRepository;
//   @override
//   State<App> createState() => _AppState();
// }

// class _AppState extends State<App> {
//   LoginRepository get loginRepository => widget.loginRepository;
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<AuthenticationBloc>(
//       bloc: authenticationBloc,
//       create: (BuildContext context) {  },
//       child: MaterialApp(
//         home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
//           bloc: authenticationBloc,
//           builder: (BuildContext context, AuthenticationState state) {
//             if (state is AuthenticationUninitialized) {
//               return SplashPage();
//             }
//             if (state is AuthenticationAuthenticated) {
//               return HomePage();
//             }
//             if (state is AuthenticationUnauthenticated) {
//               return LoginPage(loginRepository: loginRepository);
//             }
//             if (state is AuthenticationLoading) {
//               return LoadingIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:project_cleanarchiteture/Features/Home/presentation/screens/HomeScreen.dart';
import 'package:project_cleanarchiteture/Features/Profile/presentation/screens/profileScreen.dart';
import 'package:project_cleanarchiteture/Features/Role/Presentation/rolescreens/RoleScreen..dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/userscreens/user.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/Role.dart';
import 'package:project_cleanarchiteture/Features/auth/OTP/presentation/pages/OtpScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/CreateNewPassword/presentation/screens/CreateNewPasswordScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/ForgetPassword/presentation/screens/ForgetPasswordScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Presentation/screens/LoginScreen.dart';
import 'package:project_cleanarchiteture/Features/auth/Signup/Presentation/screens/SignupScreen.dart';
import 'package:project_cleanarchiteture/SplashScreen.dart';
import 'package:project_cleanarchiteture/WidgetComponents/scaffoldWithNestedNavigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');
final _shellNavigatorEKey = GlobalKey<NavigatorState>(debugLabel: 'shellE');
final _shellNavigatorFKey = GlobalKey<NavigatorState>(debugLabel: 'shellF');
final _shellNavigatorGKey = GlobalKey<NavigatorState>(debugLabel: 'shellG');
final _shellNavigatorHKey = GlobalKey<NavigatorState>(debugLabel: 'shellH');

const String SPLASH = "/splash";
const String SIGNIN = "/signin";
const String SIGNUP = "/signup";
const String FORGET_PASSWORD = "/forgetPassword";
const String OTP = "/otp";
const String CREATE_NEW_PASSWORD = "/createNewPassword";
// const String HOME = "/home";
// const String USER = "/user";

final GoRouter routes = GoRouter(
  initialLocation: SPLASH,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: SPLASH,
      builder: (BuildContext context, GoRouterState state) {
        return SplashView();
      },
    ),
    GoRoute(
      path: SIGNIN,

      builder: (BuildContext context, GoRouterState state) {
        return SignInView();
      },
      // pageBuilder: ((context, state) {
      //   return CustomTransitionPage(
      //     transitionDuration: const Duration(seconds: 2),
      //     // key: state.pageKey,
      //     child: SignInView(),
      //     transitionsBuilder: ((context, animation, secondaryAnimation, child) {
      //       return FadeTransition(
      //         opacity:
      //             CurveTween(curve: Curves.easeInOutCirc).animate(animation),
      //         child: child,
      //       );
      //     }),
      //   );
      // }),
    ),
    GoRoute(
      path: SIGNUP,
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          // key: state.pageKey,
          child: SignUpView(),
          transitionsBuilder: ((context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }),
        );
      }),
    ),
    GoRoute(
      path: FORGET_PASSWORD,
      // builder: (BuildContext context, GoRouterState state) {
      //   return ForgetPasswordView();
      // },
      pageBuilder: ((context, state) {
        return CustomTransitionPage(
          transitionDuration: const Duration(seconds: 1),
          // key: state.pageKey,
          child: ForgetPasswordView(),
          transitionsBuilder: ((context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }),
        );
      }),
    ),
    GoRoute(
      path: OTP,
      builder: (BuildContext context, GoRouterState state) {
        return OtpView(
          email: state.extra.toString(),
        );
      },
    ),
    GoRoute(
      path: '$CREATE_NEW_PASSWORD/:email/:otp',
      name: 'newPass',
      builder: (BuildContext context, GoRouterState state) {
        return CreateNewPasswordView(
          email: state.pathParameters['email']!,
          otp: state.pathParameters['otp']!,
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/user',
              pageBuilder: (context, state) => NoTransitionPage(
                child: User(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'userLov',
              //   builder: (context, state) => UsersLovScreen(),
              // ),
              // GoRoute(
              //   path: 'allUsers',
              //   builder: (context, state) => AllUsersScreen(),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorCKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/roleScreen',
              pageBuilder: (context, state) => NoTransitionPage(
                child: RoleScreen(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'details',
              //   builder: (context, state) => DetailsScreen(label: 'B'),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorDKey,
          routes: [
            GoRoute(
              path: '/homeScreen',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
              // routes: [
              // GoRoute(
              //   path: 'details',
              //   builder: (context, state) => DetailsScreen(label: 'B'),
              // ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorEKey,
          routes: [
            GoRoute(
              path: '/profileScreen',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'updateProfile',
              //     builder: (context, state) => ProfileUpdateView(),
              //   ),
              //   GoRoute(
              //     path: 'manageRole',
              //     builder: (context, state) => ManageRolesLovScreen(),
              //   ),
              // ],
            ),
          ],
        ),
      ],
    ),
  ],
);

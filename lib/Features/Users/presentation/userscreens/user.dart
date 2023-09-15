import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Core/Notifications_Services.dart';
import 'package:project_cleanarchiteture/Features/CRUD/bloc/user_bloc.dart';
import 'package:project_cleanarchiteture/Features/Users/data/datasources/UserDataSource.dart';
import 'package:project_cleanarchiteture/Features/Users/data/repositories/UserRepositoryImplementation.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/response/UserLovResponse.dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/bloc/userbloc_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';

class User extends StatefulWidget {
  User({Key? key}) : super(key: key);

  LoginAdmin? userdata;
  var storage = LocalData();

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  NotificationServices services = NotificationServices();

  @override
  void initState() {
    services.requestnotificationpermission();
    services.IsTokenvalid();
    // Future.delayed(Duration(microseconds: 3), () {
    //   widget.userdata = LoginAdmin.fromJson(
    //       jsonDecode(widget.storage.getUserinfo(USER_INFO).toString()));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

        // MultiBlocProvider(
        //   providers: [
        //     BlocProvider<UserBloc>(
        //       create: (BuildContext context) => UserBloc(
        //           roleLovRepo: RoleLovRepository(),
        //           userLovRepo: UserLovRepository()),
        //     )
        //   ],
        //   child:
        Scaffold(
            body: Padding(
      padding: const EdgeInsets.only(top: 80.0, left: 10, right: 10),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(children: [
          UserLovbloc(),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    ));
  }

  Widget UserLovbloc() {
    return BlocProvider(
      create: (context) => UserblocBloc(
          repository: UserRepositoryImplementation(
              userDataSource: UserDataSourceImplementation()))
        ..add(LoadingUserLov()),
      child:
          BlocBuilder<UserblocBloc, UserblocState>(builder: (context, state) {
        if (state is UserLovLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is ErrorUserLovState) {
          return Text("Error");
        }
        if (state is LoadedUserLovState) {
          List<UserLovResponse> userlist = state.users;
          return DropdownButtonFormField(
              onChanged: (value) {},
              isDense: true,
              menuMaxHeight: 300,
              borderRadius: BorderRadius.circular(20.0),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              iconSize: 20,
              iconDisabledColor: Colors.black,
              iconEnabledColor: Colors.black45,
              decoration: const InputDecoration(hintText: "Select User"),
              items:
                  userlist.map((e) => e.email.toString()).map((String uname) {
                return new DropdownMenuItem(
                    value: uname,
                    child: Row(
                      children: <Widget>[Text(uname.toString())],
                    ));
              }).toList());
        }
        return Text("Error");
      }),
    );
  }

// Widget userBolc() {
//   return BlocProvider(
//     create: (context) =>
//     UserBloc(
//         roleLovRepo: RoleLovRepository(), userLovRepo: UserLovRepository())
//       ..add(LoadUserLovEvent()),
//     child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
//       if (state is UserLovLoadingState) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//
//       if (state is UserLovErrorState) {
//         return const Center(child: Text("Error"));
//       }
//
//       if (state is UserLovLoadedState) {
//         List<UserLovResponse> userlist = state.users;
//
//         return DropdownButtonFormField(
//             onChanged: (value) {},
//             isDense: true,
//             menuMaxHeight: 300,
//             borderRadius: BorderRadius.circular(20.0),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded),
//             iconSize: 20,
//             iconDisabledColor: Colors.black,
//             iconEnabledColor: Colors.black45,
//             decoration: const InputDecoration(hintText: "Select User"),
//             items:
//             userlist.map((e) => e.email.toString()).map((String uname) {
//               return new DropdownMenuItem(
//                   value: uname,
//                   child: Row(
//                     children: <Widget>[Text(uname.toString())],
//                   ));
//             }).toList());
//       }
//
//       return Text("Errror");
//     }),
//   );
// }
//
// Widget blocBody() {
//   return BlocProvider(
//     create: (context) =>
//     UserBloc(
//         roleLovRepo: RoleLovRepository(), userLovRepo: UserLovRepository())
//       ..add(LoadRoleLovEvent()),
//     child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
//       if (state is RoleLovLoadingState) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//
//       if (state is RoleLovErrorState) {
//         return const Center(child: Text("Error"));
//       }
//
//       if (state is RoleLovLoadedState) {
//         List<RoleLovResponse> rolelist = state.roles;
//
//         return DropdownButtonFormField(
//             onChanged: (value) {},
//             isDense: true,
//             menuMaxHeight: 300,
//             borderRadius: BorderRadius.circular(20.0),
//             icon: const Icon(Icons.keyboard_arrow_down_rounded),
//             iconSize: 20,
//             iconDisabledColor: Colors.black,
//             iconEnabledColor: Colors.black45,
//             decoration: const InputDecoration(hintText: "Select Role"),
//             items: rolelist.map((e) => e.id.toString()).map((String uname) {
//               return new DropdownMenuItem(
//                   value: uname,
//                   child: Row(
//                     children: <Widget>[Text(uname.toString())],
//                   ));
//             }).toList());
//       }
//
//       return Text("Eeor");
//     }),
//   );
// }
}

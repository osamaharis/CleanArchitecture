import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Core/Notifications_Services.dart';
import 'package:project_cleanarchiteture/Features/Role/Domain/model/RoleResponse.dart';
import 'package:project_cleanarchiteture/Features/Role/Presentation/bloc/rolebloc_bloc.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/response/UserLovResponse.dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/bloc/userbloc_bloc.dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/usercomponents/UserCard.dart';
import 'package:project_cleanarchiteture/Features/Users/presentation/usercomponents/UserCardSkeleton.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Theme/CustomTheme.dart';
import 'package:project_cleanarchiteture/Utils/TextResources.dart';

import '../../../../Utils/Extensions.dart';

class User extends StatefulWidget {
  User({Key? key}) : super(key: key);

  LoginAdmin? userdata;

  var storage = LocalData();

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> with LocalData {
  NotificationServices services = NotificationServices();
  int _selected_user_id = 0;
  int? userId;
  String? initialValue;
  List<UserLovResponse> userlist = [];

  @override
  void initState() {
    services.requestnotificationpermission();
    services.IsTokenvalid();
    Future.delayed(Duration(seconds: 3), () async {
      await getUserinfo(USER_INFO);

      final String? userd = savedLoginData;

      widget.userdata = LoginAdmin.fromJson(jsonDecode(userd!));
      context
          .read<UserblocBloc>()
          .add(LoadedUserLovEvent(token: widget.userdata?.token ?? ""));
      context
          .read<RoleblocBloc>()
          .add(LoadedRoleLovEvent(token: widget.userdata?.token ?? ""));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          title: Text(
            txtuser,
            style: TextStyle(
                fontSize: plain_text_size.toDouble(),
                color: Colors.black,
                fontWeight: FontWeight.w400),
          ),
          leading: IconButton(
            color: Colors.white,
            hoverColor: Colors.purpleAccent,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(children: [
              UserLovbloc(),
              SizedBox(height: 10),
              RoleLovBloc(),
              SizedBox(
                height: 20,
              ),
              UserByIdBloc()
            ]),
          ),
        ));
  }

  Widget UserLovbloc() {
    return BlocBuilder<UserblocBloc, UserblocState>(
      builder: (context, state) {
        if (state is LoadingUserLovState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ErrorUserLovState) {
          return Text("Error Osama");
        }
        if (state is LoadedUserLovState) {
          // List<UserLovResponse> userlist = state.users;
          userlist = state.users;
          return UsersList();
        }
        return UsersList();
      },
    );
  }

  Widget UsersList() {
    return DropdownButtonFormField(
        value: initialValue,
        onChanged: (value) {
          if (value != null) {
            var data = userlist.firstWhere((element) =>
                (element.fullName.en.toString() ==
                    removeDigits(value) as String));
            _selected_user_id = data.id;
            LoadDatabyId(_selected_user_id!, widget.userdata?.token ?? "");
            setState(() {
              initialValue = value.toString();
            });
          }
        },
        isDense: true,
        menuMaxHeight: 300,
        borderRadius: BorderRadius.circular(20.0),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        iconSize: 20,
        iconDisabledColor: Colors.black,
        iconEnabledColor: Colors.black45,
        decoration: const InputDecoration(
            hintText: "Select User", hintStyle: TextStyle(fontSize: 10)),
        items:
            userlist.map((e) => e.fullName.en.toString()).map((String uname) {
          return new DropdownMenuItem(
              value: uname,
              child: Row(
                children: <Widget>[Text(removeDigits(uname.toString()))],
              ));
        }).toList());
  }

  void LoadDatabyId(int userId, String token) {
    context
        .read<UserblocBloc>()
        .add(LoadedUserbyIdEvent(id: userId, token: token));
  }

  String removeDigits(final String s) {
    return s.replaceAll(new RegExp(r"[0-9]+"), "");
  }

  Widget RoleLovBloc() {
    return BlocBuilder<RoleblocBloc, RoleblocState>(builder: (context, state) {
      if (state is LoadingRoleLovState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorRoleLovState) {
        return Text("Error");
      }
      if (state is LoadedRoleLovState) {
        List<RoleResponse> role = state.role;
        return DropdownButtonFormField(
            onChanged: (value) {
              if (value != null) {
                var data = role.firstWhere((element) =>
                    (element.name.toString() == (value) as String));
                _selected_user_id = data.id;
              }
            },
            isDense: true,
            menuMaxHeight: 300,
            borderRadius: BorderRadius.circular(20.0),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            iconSize: 20,
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black45,
            decoration: const InputDecoration(
                hintText: "Select User", hintStyle: TextStyle(fontSize: 10)),
            items: role.map((e) => e.name.toString()).map((String uname) {
              return new DropdownMenuItem(
                  value: uname,
                  child: Row(
                    children: <Widget>[Text(uname.toString())],
                  ));
            }).toList());
      }
      return Text("Error");
    });
  }

  Widget UserByIdBloc() {
    return BlocBuilder<UserblocBloc, UserblocState>(builder: (context, state) {
      if (state is LoadingUserbyIdLovState) {
        return UserCardSkeleton(isloaded: true);
      }
      if (state is ErrorUserByIdState) {
        return UserCardSkeleton(isloaded: false);
      }
      if (state is LoadedUserbyIdState) {
        UserLovResponse? userdata = state.users;
        return UserCard(
          text1: userdata!.fullName.en.toString(),
          text: userdata.gender.toString(),
        );
      }
      return UserCardSkeleton(isloaded: false);
    });
  }
}

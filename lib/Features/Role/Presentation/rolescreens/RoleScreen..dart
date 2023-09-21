import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_cleanarchiteture/Core/LocalData.dart';
import 'package:project_cleanarchiteture/Features/Role/Domain/model/RoleResponse.dart';
import 'package:project_cleanarchiteture/Features/Role/Presentation/bloc/rolebloc_bloc.dart';
import 'package:project_cleanarchiteture/Features/auth/Login/Domain/entities/AdminSignInResponse.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';

class RoleScreen extends StatefulWidget {
  RoleScreen({Key? key}) : super(key: key);

  LoginAdmin? userdata;
  var storage = LocalData();

  @override
  State<RoleScreen> createState() => _RoleScreenState();
}

class _RoleScreenState extends State<RoleScreen> with LocalData {
  int _selected_role_id = 0;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () async {
      final userd = await getUserinfo(USER_INFO);
      setState(() {
        widget.userdata = LoginAdmin.fromJson(jsonDecode(userd));
        // context
        //     .read<UserblocBloc>()
        //     .add(LoadedUserLovEvent(token: widget.userdata?.token ?? ""));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget RoleLovBloc() {
    return BlocBuilder(builder: (context, state) {
      if (state is LoadingRoleLovState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ErrorRoleLovState) {
        return Text("Error");
      }
      if (state is LoadedRoleLovState) {
        List<RoleResponse> userlist = state.role;
        return DropdownButtonFormField(
            onChanged: (value) {
              if (value != null) {
                var data = userlist.firstWhere((element) =>
                    (element.name.en.toString() == (value) as String));
                _selected_role_id = data.id;
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
                userlist.map((e) => e.name.en.toString()).map((String uname) {
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
}

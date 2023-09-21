import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_cleanarchiteture/Features/Users/domain/response/UserLovResponse.dart';
import 'package:project_cleanarchiteture/Theme/CustomTheme.dart';
import 'package:project_cleanarchiteture/Utils/Extensions.dart';


class UserCard extends StatefulWidget {
  UserCard({super.key, required this.text1, required this.text});

  String text;
  String text1;

  @override
  State<UserCard> createState() => _UserState();
}

class _UserState extends State<UserCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Card(

        color: Colors.white,
        shadowColor: grey,
        child: Container(
          width: double.maxFinite,
          height: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding:
                  const EdgeInsets.only(left: 5.0, bottom: 5.0, top: 5.0),
                  child:
                    Text(
                      "Gender: ${widget.text1}",
                      style: TextStyle(
                          fontSize: other.toDouble(),
                          color: black.toColor(),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
              Padding(
                padding:
                const EdgeInsets.only(left: 5.0, bottom: 5.0, top: 5.0),
                child:
                Text(
                  "Name: ${widget.text}",
                  style: TextStyle(
                      fontSize: other.toDouble(),
                      color: black.toColor(),
                      fontWeight: FontWeight.w600),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
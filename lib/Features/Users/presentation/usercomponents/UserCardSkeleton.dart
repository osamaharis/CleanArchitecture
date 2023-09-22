import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserCardSkeleton extends StatelessWidget {
  UserCardSkeleton({Key? key, required this.isloaded}) : super(key: key);

  bool isloaded;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      direction: ShimmerDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 0.0, bottom: 5.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      )),
                  Expanded(
                      flex: 8,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                height: 20.0,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                height: 20.0,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(0.0
                                // bottomLeft: Radius.circular(15.0),
                                // topLeft: Radius.circular(15.0)
                                )),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

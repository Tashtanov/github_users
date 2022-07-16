import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:github_users/data/model/user_model.dart';

class UserDetail extends StatelessWidget {
  final User getAll;
  const UserDetail({Key? key,
  required  this.getAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.3,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        "${getAll.avatarUrl}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Container(),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: NetworkImage("${getAll.avatarUrl}"),
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "${getAll.login}",
                      style: TextStyle(fontSize: 35),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Github repositories  ||  ${getAll.reposUrl?.length.toString()}",
                      style: TextStyle(
                          fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Text("${getAll.htmlUrl}",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Folowers",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            Text(
                              "${getAll.followersUrl?.length.toString()}",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Column(
                          children: [
                            Text(
                              "Folowing",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            Text(
                              "${getAll.followingUrl?.length.toString()}",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "URL API",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            Text(
                              "${getAll.url}",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Stars  ",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black54),
                            ),
                            Text(
                              "${getAll.starredUrl!.length.toString()}",
                              style:
                              TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_users/data/model/user_model.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:github_users/presentation/bloc/get_user_cubit/get_user_cubit.dart';
import 'package:github_users/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:github_users/presentation/screen/user_detail.dart';

class UserList extends StatefulWidget {
  const UserList({
    Key? key,
  }) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final scrollController = ScrollController();

  void setScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<GetUserCubit>(context).loadUser();
        }
      }
    });
  }
  @override
  void initState() {
    super.initState();
    initialization();
  }

  Future<void> initialization() async {
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    setScrollController(context);
    BlocProvider.of<GetUserCubit>(context).loadUser();
    return Scaffold(
      appBar: AppBar(
        title: Text("Github Users"),
        centerTitle: true,
      ),
      body: BlocConsumer<InternetConnectionBloc, InternetConnectionState>(
        listener: (context, state) {
          if (state is InternetConnectionSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Internet Connetcted")));
          } else if (state is InternetConnectionFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Internet NotConnetcted")));
          }
        },
        builder: (context, state) {
          if (state is InternetConnectionFailureState) {
            return const Center(
              child: Text(
                "Internet NotConnected",
                style: TextStyle(fontSize: 30),
              ),
            );
          } else if (state is InternetConnectionSuccessState) {
            return Center(child: BlocBuilder<GetUserCubit, GetUserState>(
              builder: (context, state) {
                if (state is GetUserLoading && state.isFirstFetch) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<User> users = [];
                bool isLoading = false;
                if (state is GetUserLoading) {
                  users = state.oldUserList;
                  isLoading = true;
                } else if (state is GetUserLoaded) {
                  users = state.UserList;
                }
                return ListView.builder(
                    controller: scrollController,
                    itemCount: users.length + (isLoading ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index < users.length) {
                        return Card(
                            child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDetail(
                                          getAll: users[index],
                                        )));
                          },
                          title: Text("${users[index].login}"),
                          subtitle: Text('${users[index].htmlUrl}'),
                          leading: CircleAvatar(
                            child: Image.network("${users[index].avatarUrl}"),
                          ),
                        ));
                      } else {
                        Timer(Duration(milliseconds: 30), () {
                          scrollController.jumpTo(
                              scrollController.position.maxScrollExtent);
                        });

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    });
              },
            ));
          } else {
            return const Center(
              child: Text(
                "Not Internet",
                style: TextStyle(fontSize: 35),
              ),
            );
          }
        },
      ),
    );
  }
}

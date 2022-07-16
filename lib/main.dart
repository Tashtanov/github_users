import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:github_users/data/user_service.dart';
import 'package:github_users/data/repository/user_repository.dart';
import 'package:github_users/presentation/bloc/get_user_cubit/get_user_cubit.dart';
import 'package:github_users/presentation/bloc/internet_connection_bloc/internet_connection_bloc.dart';
import 'package:github_users/presentation/screen/user_list.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp(
    userRepository: UserRepository(Service()),
  ));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<GetUserCubit>(
              create: (context) => GetUserCubit(userRepository),
            ),
            BlocProvider<InternetConnectionBloc>(
              create: (context) => InternetConnectionBloc(),
            ),
          ],
          child: UserList(),
        ));
  }
}

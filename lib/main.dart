import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/presentation/controllers/global_bloc/global_bloc.dart';

import 'src/presentation/shared/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      fontFamily: "Montserrat",
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );

    return BlocProvider(
      create: (context) => GlobalBloc(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: themeData,
        routerConfig:AppRouter.router,
      ),
    );
  }
}



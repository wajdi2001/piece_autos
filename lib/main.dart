import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/cache_helper.dart';
import 'package:piece_autos/core/utils/dio_helper.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'src/presentation/controllers/blocObserver.dart';
import 'src/presentation/controllers/global_bloc/global_bloc.dart';

import 'src/presentation/shared/router/app_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
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
      child: ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: MaterialApp.router(
          title: 'Flutter Demo',
          theme: themeData,
          routerConfig:AppRouter.router,
        ),
      ),
    );
  }
}



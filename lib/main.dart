import 'package:flutter/material.dart';
import 'src/presentation/shared/router/app_router.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      fontFamily: "Montserrat",
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: themeData,
      onGenerateRoute: (settings) => AppRouter.generateRoute(settings),
        initialRoute: AppRouter.homePageRoute,
    );
  }
}


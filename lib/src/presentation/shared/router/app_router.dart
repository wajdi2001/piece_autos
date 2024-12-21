import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/Item_page/item_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/home_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/custom_body_widget.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _tabNavigatorKey1 = GlobalKey<NavigatorState>();
final _tabNavigatorKey2 = GlobalKey<NavigatorState>();
class AppRouter {
  static const homeRoute = '/home';
  static const itemsRoute = '/items';

  AppRouter._();
  
  static final router = GoRouter(
    initialLocation: homeRoute,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          // Pass the correct StatefulNavigationShell instance
          return HomePage(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Home
          StatefulShellBranch(
            navigatorKey: _tabNavigatorKey1,
            routes: [
              GoRoute(
                path: homeRoute,
                builder: (context, state) => CustomBodyWidget(
                  onPressed: () 
                     {

                      //context.read<GlobalBloc>().add(GlobalNavigatorEvent(buildContext: context, route: "/liste", index: 1));
                      StatefulNavigationShell.of(context).goBranch(1);
                      
                     }
                   // FIXED
                ),
              ),
            ],
          ),
          // Branch 2: Items
          StatefulShellBranch(
            navigatorKey: _tabNavigatorKey2,
            routes: [
              GoRoute(
                path: itemsRoute,
                builder: (context, state) => const ItemPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const ErrorPage(),
  );
}
// Error Page for undefined routes
class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('Page not found!'),
      ),
    );
  }
}
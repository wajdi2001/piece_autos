import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/Item_page/item_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/category_details_page/category_detail_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/home_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/custom_body_widget.dart';

import '../../layouts/client_layouts/product_details_page/product_details_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _tabNavigatorKey1 = GlobalKey<NavigatorState>();
final _tabNavigatorKey2 = GlobalKey<NavigatorState>();
final _tabNavigatorKey3 = GlobalKey<NavigatorState>();
final _tabNavigatorKey4 = GlobalKey<NavigatorState>();

class AppRouter {
  static const homeRoute = '/home';
  static const itemsRoute = '/items';
  static const categorieDetailsRoute = '/category';
  static const productRoute = '/product';

  AppRouter._();

  static final router = GoRouter(
    initialLocation: homeRoute,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
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
                  onPressed: () {
                    StatefulNavigationShell.of(context).goBranch(1);
                  },
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
                builder: (context, state) => ItemPage(
                  onTapCategory: () {

                    StatefulNavigationShell.of(context).goBranch(2);
                  },
                ),
              ),
            ],
          ),
          // Branch 3: Category Details
          StatefulShellBranch(
            navigatorKey: _tabNavigatorKey3,
            routes: [
              // Route par défaut sans paramètres dynamiques
             /* GoRoute(
                path: '/category',
                builder: (context, state) => const Placeholder(), // Une page par défaut
              ),*/
              // Route avec paramètres dynamiques
              GoRoute(
                path: categorieDetailsRoute, // '/item/:title'
                builder: (context, state) {
                  return CategoryDetailPage(
                    onTapItemdetails: () => StatefulNavigationShell.of(context).goBranch(3),
                  );
                },
              ),
            ],
          ),


          StatefulShellBranch(
            navigatorKey: _tabNavigatorKey4,
            routes: [
              GoRoute(
                path: productRoute,
                builder: (context, state) => ProductDetailPage()
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

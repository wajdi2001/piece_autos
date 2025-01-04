import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:piece_autos/src/presentation/layouts/admin_dashboard/admin_layout.dart';
import 'package:piece_autos/src/presentation/layouts/auth_layouts/auth_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/tags_page/tags_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/category_details_page/category_detail_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/home_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/custom_body_widget.dart';

import '../../controllers/global_bloc/global_bloc.dart';
import '../../layouts/client_layouts/product_details_page/product_details_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _tabNavigatorKey1 = GlobalKey<NavigatorState>();
final _tabNavigatorKey2 = GlobalKey<NavigatorState>();
final _tabNavigatorKey3 = GlobalKey<NavigatorState>();
final _tabNavigatorKey4 = GlobalKey<NavigatorState>();
final _tabNavigatorKey5 = GlobalKey<NavigatorState>();

class AppRouter {
  static const homeRoute = '/home';
  static const itemsRoute = '/items';
  static const categorieDetailsRoute = '/category';
  static const productRoute = '/product';
  static const adminDashboardRoute = '/admin'; // Admin Dashboard Route
  static const authRoute = '/auth'; // Auth Route
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
                builder: (context, state) =>
                    BlocBuilder<GlobalBloc, GlobalState>(
                  builder: (context, state) {
                    return CustomBodyWidget(
                      onPressed: () {
                        if (state.selectedYearOfConstruction != null) {
                          context
                              .read<GlobalBloc>()
                              .add(GlobalGetAllTagsEvent());
                          StatefulNavigationShell.of(context).goBranch(1);
                        }
                      },
                    );
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
                builder: (context, state) => TagsPage(
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
              GoRoute(
                path: categorieDetailsRoute,
                builder: (context, state) {
                  return CategoryDetailPage(
                    onTapItemdetails: () =>
                        StatefulNavigationShell.of(context).goBranch(3),
                  );
                },
              ),
            ],
          ),
        //branch 4: Product Details
          StatefulShellBranch(
            navigatorKey: _tabNavigatorKey4,
            routes: [
              GoRoute(
                  path: productRoute,
                  builder: (context, state) =>
                      BlocBuilder<GlobalBloc, GlobalState>(
                        builder: (context, state) {
                          
                          return ProductDetailPage();
                        },
                      )),
            ],
          ),
          //branch 5: auth page 
          // Add auth routes here
        StatefulShellBranch(
          navigatorKey: _tabNavigatorKey5,
          routes: 
      [
         GoRoute(
                  path: authRoute,
                  builder: (context, state) =>
                      BlocBuilder<GlobalBloc, GlobalState>(
                        builder: (context, state) {
                          
                          return AuthPage();
                        },
                      )),
      ])
        ],
      ),
      // Add Admin Dashboard as a standalone route
      GoRoute(
        path: adminDashboardRoute,
        builder: (context, state) => const AdminDashboard(),
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

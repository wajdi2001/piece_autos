import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/home_app_bar_widget.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/home_drawer.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/service_widget.dart';

import 'widgets/contact_footer_Widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage( {super.key,required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
  
    super.initState();
    context.read<GlobalBloc>()..add(GlobalGetAllBrandsEvent())..add(GlobalGetAllCarModelEvent());
  }
  @override
  
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<GlobalBloc, GlobalState>(
        buildWhen: (previous, current) => current.status == GlobalStatus.loaded,
        builder: (context, state) {
          return Scaffold(
              body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/mechanical_back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(children: [
              HomeAppBarWidget()
                ..animate()
                    .fadeIn(duration: 600.ms, delay: 100.ms)
                    .slideY(begin: -0.2, end: 0),
              SizedBox(height: 10),
              //state.indexPage.getHomePageBody(),
              widget.navigationShell,
              SizedBox(height: 20),
              ServiceWidget()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 100.ms)
                  .slideY(begin: -0.2, end: 0),
              SizedBox(height: 20),
              ContactFooter()
                  .animate()
                  .fadeIn(duration: 600.ms, delay: 200.ms)
                  .slideY(begin: -0.2, end: 0),
            ]),
          ),
          ////////////////////////////////
          
          
          drawer: HomeDrawer());
        },
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../controllers/global_bloc/global_bloc.dart';

class HomePageBody extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const HomePageBody({super.key,required this.navigationShell});
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return navigationShell;
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';
import 'package:piece_autos/src/presentation/layouts/admin_dashboard/widgets/Brand_crud_ui_widget.dart';
import 'package:piece_autos/src/presentation/layouts/admin_dashboard/widgets/CarModel_crud_ui_widget.dart';
import 'package:piece_autos/src/presentation/layouts/admin_dashboard/widgets/Tva_crud_ui_widget.dart';

class MainContent extends StatelessWidget {
  const MainContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        final selectedMenu = state.currentMenu;
        switch (selectedMenu) {
          case 'Brand':
            content = BrandCrudUI();
            break;
          case 'CarModel':
            content = CarModelCrudUI();
            break;
          case 'TVA':
            content = TVACrudUI();
            break;
          default:
            content = Center(child: Text('Select a menu item.'));
        }
        return Container(
          padding: EdgeInsets.all(16),
          child: content,
        );
      },
    );
  }
}

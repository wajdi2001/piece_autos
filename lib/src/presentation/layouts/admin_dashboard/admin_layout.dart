import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';
import 'package:piece_autos/src/presentation/layouts/admin_dashboard/widgets/main_content_widget.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard> {
  String selectedMenu = 'Brand'; // Default menu

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => sl<DashboardBloc>(),
      child: SafeArea(
        child: Scaffold(
          body: Row(
            children: [
              // Sidebar
              NavigationSidebar(),
              //Main Content Area
              Expanded(
                child: MainContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationSidebar extends StatelessWidget {
  const NavigationSidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.blueGrey[900],
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          final selectedMenu = state.currentMenu;
          return Column(
            children: [
              DrawerHeader(
                child: Text(
                  'Admin Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SidebarMenuItem(
                title: 'Brand',
                isSelected: selectedMenu == 'Brand',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(DashboadChnageMenuEvent(menu: "Brand")),
              ),
              SidebarMenuItem(
                title: 'Car Model',
                isSelected: selectedMenu == 'CarModel',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(DashboadChnageMenuEvent(menu: "CarModel")),
              ),
              SidebarMenuItem(
                title: 'TVA',
                isSelected: selectedMenu == 'TVA',
                onTap: () => context
                    .read<DashboardBloc>()
                    .add(DashboadChnageMenuEvent(menu: "TVA")),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SidebarMenuItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarMenuItem({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[400],
        ),
      ),
      selected: isSelected,
      onTap: onTap,
    );
  }
}

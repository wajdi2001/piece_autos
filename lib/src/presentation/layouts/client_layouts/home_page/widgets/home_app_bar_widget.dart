import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/shared/router/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../core/services/enums.dart';
import '../../../../../data/models/item_model.dart';
import '../../../../controllers/global_bloc/global_bloc.dart';
import '../../../../shared/library/searchble_drop_down/searchable_paginated_dropdown.dart';

class HomeAppBarWidget extends StatelessWidget {
  final VoidCallback navToProductPage;
  const HomeAppBarWidget({super.key,required this.navToProductPage});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Top AppBar Section
              Container(
                height: 75,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ResponsiveBreakpoints.of(context).isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo
                          Container(
                              height: 100,
                              width: 100,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/pieceAutoLogo.png'),
                                  fit: BoxFit.scaleDown,
                                ),
                              )),
                          // Menu Items
                          Row(
                            children: [
                              _buildMenuItem("Huile et additifs"),
                              _buildMenuItem("Embrayages"),
                              _buildMenuItem("Accessoires"),
                              _buildMenuItem("A propos"),
                              _buildMenuItem("Contact"),
                            ],
                          ),
                          // Icons
                          Row(
                            children: [
                              if (ResponsiveBreakpoints.of(context).isMobile ||
                                  ResponsiveBreakpoints.of(context).isPhone ||
                                  ResponsiveBreakpoints.of(context).isTablet)
                                IconButton(
                                  icon: const Icon(Icons.search,
                                      color: Colors.black),
                                  onPressed: () {},
                                ),
                                IconButton(
                                    icon: const Icon(Icons.person,
                                        color: Colors.black),
                                    onPressed: () {
                                      AppRouter.router.go(AppRouter.adminDashboardRoute);
                                    },
                                  ),
                              IconButton(
                                icon: const Icon(Icons.shopping_cart,
                                    color: Colors.black),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    : !state.isOpenedSearch
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Menu Icon for Drawer
                              IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                icon:
                                    const Icon(Icons.menu, color: Colors.black),
                              ),
                              // Logo
                              Container(
                                  height: 100,
                                  width: 100,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/pieceAutoLogo.png'),
                                      fit: BoxFit.scaleDown,
                                    ),
                                  )),
                              // Icons
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.search,
                                        color: Colors.black),
                                    onPressed: () {
                                      context.read<GlobalBloc>().add(
                                          GlobalSwitchSearchBarEvent(
                                              show: true));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.person,
                                        color: Colors.black),
                                    onPressed: () {
                                      AppRouter.router.goNamed(AppRouter.adminDashboardRoute);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.shopping_cart,
                                        color: Colors.black),
                                    onPressed: () {
                                      Scaffold.of(context).openEndDrawer();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                          children: [
                            Icon(Icons.car_repair),
                            Expanded(
                              child: SearchableDropdown<ItemModel>.future(
                                dialogOffset: 0.3,
                                futureRequest: () async {
                                  // Trigger the BLoC event to fetch items
                                  context
                                      .read<GlobalBloc>()
                                      .add(GlobalGetAllItemsEvent());
                        
                                  // Wait for the state to update and return the items
                                  final state = await context
                                      .read<GlobalBloc>()
                                      .stream
                                      .firstWhere(
                                        (state) =>
                                            state.status ==
                                            GlobalStatus.loaded,
                                      );
                        
                                  // Map the items to SearchableDropdownMenuItem
                                  return state.items.map((item) {
                                    return SearchableDropdownMenuItem<
                                        ItemModel>(
                                      label:
                                          item.name, // Customize item label
                                      value: item,
                                      child: Text(item
                                          .name), // Customize item display
                                    );
                                  }).toList();
                                },
                                hintText:
                                    const Text("Rechercher une pièce"),
                                searchHintText:
                                    "Entrer la référence ou la pièce",
                                onChanged: (ItemModel? selectedItem) {
                                  // Handle selection
                                  if (selectedItem != null) {
                                    context.read<GlobalBloc>().add(GlobalSelectItemEvent(itemId: selectedItem.id));
                                  }
                                },
                                noRecordText: const Center(
                                    child: Text("No items found")),
                                trailingIcon:
                                    const Icon(Icons.arrow_drop_down),
                                //trailingClearIcon: const Icon(Icons.clear),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<GlobalBloc>().add(
                                    GlobalSwitchSearchBarEvent(
                                        show: false));
                              },
                              icon: const Icon(Icons.close,
                                  color: Colors.black),
                            ),
                          ],
                        ),
              ),
              const SizedBox(height: 10),
              // Search Section
              if (ResponsiveBreakpoints.of(context).isDesktop)

                Container(
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: SearchableDropdown<ItemModel>.future(
                    isDialogExpanded: false,
                    dialogOffset: 0.3,
                    futureRequest: () async {
                      // Trigger the BLoC event to fetch items
                      context.read<GlobalBloc>().add(GlobalGetAllItemsEvent());

                      // Wait for the state to update and return the items
                      final state =
                          await context.read<GlobalBloc>().stream.firstWhere(
                                (state) => state.status == GlobalStatus.loaded,
                              );

                      // Map the items to SearchableDropdownMenuItem
                      return state.items.map((item) {
                        return SearchableDropdownMenuItem<ItemModel>(
                          label: item.name, // Customize item label
                          value: item,
                          child: Text(item.name), // Customize item display
                        );
                      }).toList();
                    },
                    hintText: const Text("Rechercher une pièce"),
                    searchHintText: "Entrer la référence ou la pièce",
                    onChanged: (ItemModel? selectedItem) {
                      // Handle selection
                      if (selectedItem != null) {
                     context.read<GlobalBloc>().add(GlobalSelectItemEvent(itemId: selectedItem.id));
                     navToProductPage();

                      }
                    },
                    noRecordText: const Center(child: Text("No items found")),
                    trailingIcon: const Icon(Icons.arrow_drop_down),
                    //trailingClearIcon: const Icon(Icons.clear),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  // Helper method for menu items
  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';
import 'package:piece_autos/src/presentation/shared/router/app_router.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../../core/services/enums.dart';
import '../../../../../data/models/item_model.dart';
import '../../../../controllers/global_bloc/global_bloc.dart';
import '../../../../shared/library/searchble_drop_down/searchable_paginated_dropdown.dart';
import 'package:badges/badges.dart' as badges;
class HomeAppBarWidget extends StatelessWidget {
  final VoidCallback navToProductPage;
  const HomeAppBarWidget({super.key, required this.navToProductPage});

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
                
                child: ResponsiveBreakpoints.of(context).isDesktop
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Logo
                          Container(
                              height: 50,
                              width: 50,
                            
                          // Search Bar
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/logoPR9.jpg'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              ),
                          // Menu Items
                          Row(
                            children: [
                              MenuItem(title:"Huile et additifs"),
                              MenuItem(title:"Embrayages"),
                              MenuItem(title:"Accessoires"),
                              MenuItem(title:"A propos"),
                              MenuItem(title:"Contact"),
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
                              Container(
                                height: 40,
                                width: 40,
                                
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white

                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.person,
                                      color: Color(0xFF00bcd4), ),
                                  onPressed: () {
                                    AppRouter.router
                                        .go(AppRouter.adminDashboardRoute);
                                  },
                                ),
                              ),
                              const SizedBox(width: 5,),
                              Container(
                                height: 40,
                                width: 40,
                                
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white

                                ),
                                child: Center(
                                  child: badges.Badge(
                                    showBadge: state.shoppingCart.isNotEmpty,
                                    badgeAnimation: badges.BadgeAnimation.rotation(
                                          animationDuration: Duration(seconds: 1),
                                          colorChangeAnimationDuration: Duration(seconds: 1),
                                          loopAnimation: false,
                                          curve: Curves.fastOutSlowIn,
                                          colorChangeAnimationCurve: Curves.easeInCubic,
                                        ),
                                   ignorePointer:true,
                                    badgeContent: Text(state.shoppingCart.length
                                        .toString(),style: TextStyle(color: Colors.white),), // Display the number of items in the cart
                                    child: IconButton(
                                      icon: const Icon(Icons.shopping_cart,
                                          color:Color(0xFF00bcd4), ),
                                      onPressed: () {
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                    ),
                                  ),
                                ),
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
                                  height: 50,
                              width: 50,
                            
                          // Search Bar
                              decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/logoPR9.jpg'),
                                      fit: BoxFit.cover,
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
                                      AppRouter.router.goNamed(
                                          AppRouter.adminDashboardRoute);
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
                                  hintText: const Text("Rechercher une pièce"),
                                  searchHintText:
                                      "Entrer la référence ou la pièce",
                                  onChanged: (ItemModel? selectedItem) {
                                    // Handle selection
                                    if (selectedItem != null) {
                                      context.read<GlobalBloc>().add(
                                          GlobalSelectItemEvent(
                                              itemId: selectedItem.id));
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
                                      GlobalSwitchSearchBarEvent(show: false));
                                },
                                icon: const Icon(Icons.close,
                                    color: Colors.black),
                              ),
                            ],
                          ),
              ),
              Divider(
                color:Color(0xFF00bcd4) ,
                thickness: 2,

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
                        context.read<GlobalBloc>().add(
                            GlobalSelectItemEvent(itemId: selectedItem.id));
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
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final String title;

  const MenuItem({super.key, required this.title});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        decoration: BoxDecoration(
          border: _isHovered
              ? Border(
                  bottom: BorderSide(
                    color: Colors.cyan, // Highlight color
                    width: 2.0,
                  ),
                )
              : null,
        ),
        child: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: _isHovered ? Colors.cyan : Colors.white, // Text color changes on hover
            letterSpacing: _isHovered ? 1.5 : 1.0, // Subtle animation for letter spacing
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/data/models/car_model_model.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../controllers/global_bloc/global_bloc.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Top AppBar Section
          Container(
            padding: const EdgeInsets.all(8),
            height: 75,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: AppColors.primaryRedColor,
            ),
            child: ResponsiveBreakpoints.of(context).isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMenuItem("Huiles et additifs"),
                      _buildMenuItem("Embrayages"),
                      _buildMenuItem("Accessoires"),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/pieceAutoLogo.png'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                      _buildMenuItem("Mon compte"),
                      _buildMenuItem("Panier"),
                      _buildMenuItem("A propos"),
                    ],
                  )
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.menu, color: Colors.white),
                      ),
                      Container(
                        height: 50,
                        width: 75,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/pieceAutoLogo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
          // Search Section
          BlocBuilder<GlobalBloc, GlobalState>(
            builder: (context, state) {
              String selectedCarModelName = '';
              String selectedBrandName = '';

              if (state.selectedCarModelId != null &&
                  state.selectedBrandId != null &&
                  state.selectedYearOfConstruction != null) {
                selectedCarModelName = state.carModels
                    .firstWhere((element) => element.id == state.selectedCarModelId,
                        orElse: () => CarModelModel(id: '', name: '',brandId: '',yearOfConstruction: 0))
                    .name;
                selectedBrandName = state.brands
                    .firstWhere((element) => element.id == state.selectedBrandId,
                        orElse: () => BrandModel(id: '', name: '',image: ''))
                    .name;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment:state.selectedCarModelId != null &&
                  state.selectedBrandId != null &&
                  state.selectedYearOfConstruction != null?MainAxisAlignment.start: MainAxisAlignment.center,
                    children: [
                      if (state.selectedCarModelId != null &&
                  state.selectedBrandId != null &&
                  state.selectedYearOfConstruction != null&& ResponsiveBreakpoints.of(context).isDesktop)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedBrandName,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                state.selectedYearOfConstruction?.toString() ?? '',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(width: 10),
                      Text(
                        selectedCarModelName,
                        style: const TextStyle(color: Colors.white),
                      ),
                        ],
                      ),
                       state.selectedCarModelId != null &&
                  state.selectedBrandId != null &&
                  state.selectedYearOfConstruction != null&& ResponsiveBreakpoints.of(context).isDesktop?
                      const SizedBox(width: 250):const SizedBox(width: 50),
                  Center(
                    child: const Text(
                      'Rechercher une pièce',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                    ],
                  ),
                  
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Entrer la référence ou la pièce',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Helper method for menu items
  Widget _buildMenuItem(String title) {
    return Expanded(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
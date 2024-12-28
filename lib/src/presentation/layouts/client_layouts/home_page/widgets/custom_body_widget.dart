import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';
import 'package:piece_autos/src/presentation/shared/library/searchble_drop_down/searchable_paginated_dropdown.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../controllers/global_bloc/global_bloc.dart';

class CustomBodyWidget extends StatelessWidget {
  final VoidCallback onPressed;

  CustomBodyWidget({
    super.key,
    required this.onPressed,
  });

  final List<String> itemsModels = [
    'C3',
    'Dacia Sandero',
    'Nissan GTR',
    'Peugeot 208'
  ];
  final List<String> itemsYears = ['2022', '2023', '2024', '2025'];
  final List<String> itemsMotorizations = ['1.2', '1.4', '1.6', '1.8'];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalBloc, GlobalState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title
                    Text(
                      'Trouvez des pièces pour votre véhicule',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    )
                        .animate()
                        .fadeIn(duration: 600.ms, delay: 100.ms)
                        .slideY(begin: -0.2, end: 0),

                    const SizedBox(height: 20),

                    // Dropdowns Section

                    _buildDropdownSection(
                      context,
                      brands: state.brands,

                    ),

                    const SizedBox(height: 10),

                    // Validate Button
                    _buildValidateButton(),

                    const SizedBox(height: 20),

                    // Registration Search Section
                    _buildRegistrationSearch(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Dropdown Section for Desktop/Tablet
  Widget _buildDropdownSection(BuildContext context,{required List<BrandModel> brands} ) {
    // Détermine le nombre de colonnes en fonction de la largeur de l'écran
    int crossAxisCount = ResponsiveBreakpoints.of(context).isDesktop ||
            ResponsiveBreakpoints.of(context).isTablet
        ? 2
        : 1; // 1 colonne pour Mobile

    // Liste des dropdowns
    final List<Map<String, dynamic>> dropdownItems = [
      {
        "hint": "Choisir la marque",
        "searchHint": "Saisir la marque",
        "items": brands.map((e) => e.name).toList(),
      },
      {
        "hint": "Choisir le modèle",
        "searchHint": "Saisir le modèle",
        "items": itemsModels,
      },
      {
        "hint": "Année",
        "searchHint": "Saisir l'année",
        "items": itemsYears,
      },
      {
        "hint": "Motorisation",
        "searchHint": "Saisir la motorisation",
        "items": itemsMotorizations,
      },
    ];

    return GridView.builder(
      shrinkWrap: true, // Important pour éviter les conflits de hauteur
      physics:
          const NeverScrollableScrollPhysics(), // Désactiver le défilement du GridView
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Nombre d'éléments par ligne
        crossAxisSpacing: 10, // Espacement horizontal entre les éléments
        mainAxisSpacing: 10, // Espacement vertical entre les éléments
        childAspectRatio: ResponsiveBreakpoints.of(context).isDesktop
            ? 15
            : ResponsiveBreakpoints.of(context).isTablet
                ? 7
                : 5,
      ),
      itemCount: dropdownItems.length, // Nombre total de dropdowns
      itemBuilder: (context, index) {
        final dropdown = dropdownItems[index];
        return _buildSearchableDropdown(
          hint: dropdown["hint"],
          searchHint: dropdown["searchHint"],
          items: dropdown["items"],
        );
      },
    );
  }

  // Searchable Dropdown Widget
  Widget _buildSearchableDropdown({
    required String hint,
    required String searchHint,
    required List<String> items,
  }) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: SearchableDropdown<String>(
        dialogOffset: 0.2,
        isDialogExpanded: false,
        searchHintText: searchHint,
        hintText: Text(hint),
        items: List.generate(
          items.length,
          (i) => SearchableDropdownMenuItem(
            value: items[i],
            label: items[i],
            child: Text(items[i]),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms, delay: 100.ms)
        .slideY(begin: -0.2, end: 0);
  }

  // Validate Button
  Widget _buildValidateButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.shade300,
      ),
      width: 200,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            "Valider",
            style: TextStyle(
              color: AppColors.theardingColor,
              fontFamily: "Montserrat",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Registration Search Section
  Widget _buildRegistrationSearch() {
    return Column(
      children: [
        const Text(
          'Recherche par immatriculation',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: 1,
              groupValue: 1,
              onChanged: (value) {},
              activeColor: Colors.white,
            ),
            const Text(
              'TU',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 10),
            Radio(
              value: 2,
              groupValue: 1,
              onChanged: (value) {},
              activeColor: Colors.white,
            ),
            const Text(
              'RS',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          width: 200,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: '*** تونس ***',
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: const Text("Rechercher"),
        ),
      ],
    );
  }
}

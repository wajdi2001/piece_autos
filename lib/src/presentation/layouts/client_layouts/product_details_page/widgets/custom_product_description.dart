import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../../data/models/item_model.dart';
import '../../../../shared/constants/app_colors.dart';

class CustomProductDescrpitionWidget extends StatelessWidget {
  final ItemModel itemModel;
  const CustomProductDescrpitionWidget({super.key,required this.itemModel}) ;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Nombre d'onglets
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Onglets
           TabBar(
            
            padding: EdgeInsets.zero,
            dividerColor: Colors.white,
            labelColor: AppColors.widgetBackground,
            unselectedLabelColor: Colors.white,
            indicatorColor: AppColors.widgetBackground,
            tabs: [
              Tab(text: "Description"),
              Tab(text: "Références OEM"),
              Tab(text: "Équivalence"),
              Tab(text: "Compatible"),
            ],
          ),
          const SizedBox(height: 16),
          // Contenu des onglets
          Container(
            height: ResponsiveBreakpoints.of(context)
                                        .isMobile ||
                                    ResponsiveBreakpoints.of(context).isPhone ||
                                    ResponsiveBreakpoints.of(context).isTablet?100:130 ,// Hauteur du contenu
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(55),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: TabBarView(
              
              children: [
                // Contenu de l'onglet "Description"
                _buildDescriptionTab(),
                // Contenu de l'onglet "Références OEM"
                _buildReferencesOEMTab(),
                // Contenu de l'onglet "Équivalence"
                _buildEquivalenceTab(),
                // Contenu de l'onglet "Compatible"
                _buildCompatibleTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour l'onglet "Description"
  Widget _buildDescriptionTab() {
    List<String> descriptionKey = itemModel.description!.keys.toList();
    List<String> descriptionValue = itemModel.description!.values.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(
          "Général",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Container(
            height: 500,
            margin: EdgeInsets.symmetric(horizontal: 18),
              child: ListView.builder(
                itemCount: descriptionKey.length,
                itemBuilder: (context, index) => _CaracteristiqueRow(label:descriptionKey[index], value: descriptionValue[index]),),
            ),
        ),
        
        
      ],
    );
  }

  // Widget pour l'onglet "Références OEM"
  Widget _buildReferencesOEMTab() {
    return const Center(
      child: Text("Références OEM disponibles ici."),
    );
  }

  // Widget pour l'onglet "Équivalence"
  Widget _buildEquivalenceTab() {
    return const Center(
      child: Text("Équivalences disponibles ici."),
    );
  }

  // Widget pour l'onglet "Compatible"
  Widget _buildCompatibleTab() {
    return const Center(
      child: Text("Compatibilité disponible ici."),
    );
  }
}

// Widget pour afficher une ligne de caractéristique
class _CaracteristiqueRow extends StatelessWidget {
  final String label;
  final String value;

  const _CaracteristiqueRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

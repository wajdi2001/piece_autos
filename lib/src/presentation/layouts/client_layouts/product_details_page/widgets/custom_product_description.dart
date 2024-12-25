import 'package:flutter/material.dart';

class CustomProductDescrpitionWidget extends StatelessWidget {
  const CustomProductDescrpitionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Nombre d'onglets
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Onglets
          const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
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
            height: 200, // Hauteur du contenu
            padding: const EdgeInsets.all(8.0),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Général",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        _CaracteristiqueRow(label: "Côté d'assemblage", value: "Essieu avant"),
        _CaracteristiqueRow(label: "Diamètre intérieur [mm]", value: "12"),
        _CaracteristiqueRow(label: "Diamètre extérieur [mm]", value: "36"),
        _CaracteristiqueRow(
          label: "Pour numéro OE",
          value: "Part of 9831626480",
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

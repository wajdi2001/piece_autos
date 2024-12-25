// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:piece_autos/src/presentation/layouts/client_layouts/Item_page/widgets/custom_item_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ItemPage extends StatelessWidget {
  final  VoidCallback onTapCategory;
  const ItemPage({super.key, required this.onTapCategory});
  

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {"title": "Amortisseurs", "image": "assets/images/amortisseurs.jpeg"},
      {"title": "Bougies d'allumage", "image": "assets/images/bougies.jpeg"},
      {
        "title": "Coupelle d'amortisseur",
        "image": "assets/images/coupelle.jpeg"
      },
      {
        "title": "Filtre d'habitacle",
        "image": "assets/images/filtre_habitacle.jpeg"
      },
      {"title": "Filtre à air", "image": "assets/images/filtre_air.jpeg"},
    ];
    return Container(
      height: categories.length * 100,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: 
          LinearGradient(
          colors: [Colors.white.withAlpha(128), // 50% opacity
      Colors.white.withAlpha(77),],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ), borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveBreakpoints.of(context).isDesktop
                ? 6
                : ResponsiveBreakpoints.of(context).isTablet
                    ? 4
                    : 2, // Deux colonnes
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: ResponsiveBreakpoints.of(context).isDesktop
                ? 0.8
                : ResponsiveBreakpoints.of(context).isTablet
                    ? 1
                    : 1, // Ajuste la taille des cartes
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return CustomItemWidget(category: category, onTapCategory: onTapCategory);
          },
        ),
      ),
    );
  }
}

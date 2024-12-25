// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/category_details_page/widgets/custom_category_item_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CategoryDetailPage extends StatelessWidget {
  final VoidCallback onTapItemdetails;
  const CategoryDetailPage({
    super.key,
    required this.onTapItemdetails,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            onTapItemdetails();
          },
          child: Container(
                height: 8* 100,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Affichage des articles pour : ${state.categoryTitile}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveBreakpoints.of(context).isDesktop
                  ? 6
                  : ResponsiveBreakpoints.of(context).isTablet
                      ? 4
                      : 2, // Deux colonnes// Deux colonnes
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: ResponsiveBreakpoints.of(context).isDesktop
                  ? 0.8
                  : ResponsiveBreakpoints.of(context).isTablet
                      ? 1
                      : 1, // Ajuste la taille des cartes
                      ),
                      itemCount: 8, // Exemple : 8 articles
                      itemBuilder: (context, index) {
                        return CustomCategoryItemWidget();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

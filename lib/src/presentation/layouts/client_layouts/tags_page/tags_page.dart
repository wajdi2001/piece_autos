// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/data/models/tag_model.dart';

import 'package:piece_autos/src/presentation/layouts/client_layouts/tags_page/widgets/custom_tags_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../controllers/global_bloc/global_bloc.dart';

class TagsPage extends StatelessWidget {
  final VoidCallback onTapCategory;
  const TagsPage({super.key, required this.onTapCategory});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        List<TagModel> categories = [];

        // Handle different states
        if (state.status == GlobalStatus.loaded) {
          categories = state.tags;

          // If items are empty, fetch from cache
          if (categories.isEmpty) {
            context.read<GlobalBloc>().add(GlobalGetAllItemsAndTagsFromCacheEvent());
          }
        }

        if (state.status == GlobalStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == GlobalStatus.error || categories.isEmpty) {
          return const Center(
            child: Text("No tags available. Please try again later."),
          );
        }
        return state.status==GlobalStatus.loading? CircularProgressIndicator(): Container(
          height: categories.length * 100,
          width: double.infinity,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha(128), // 50% opacity
                  Colors.white.withAlpha(77),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10)),
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
                return CustomItemWidget(
                    tag: category, onTapCategory: onTapCategory);
              },
            ),
          ),
        );
      },
    );
  }
}

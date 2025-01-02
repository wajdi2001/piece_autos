import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/data/models/item_model.dart';
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
        List<ItemModel> items = [];

        // Handle different states
        if (state.status == GlobalStatus.loaded) {
          items = state.items;

          // If items are empty, fetch from cache
          if (items.isEmpty) {
            context.read<GlobalBloc>().add(GlobalGetAllItemsAndTagsFromCacheEvent());
          }
        }

        if (state.status == GlobalStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == GlobalStatus.error || items.isEmpty) {
          return const Center(
            child: Text("No items available. Please try again later."),
          );
        }

        // Main UI when items are loaded
        return Container(
          height: 8 * 100,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withAlpha(128), // 50% opacity
                Colors.white.withAlpha(77),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveBreakpoints.of(context).isDesktop
                          ? 6
                          : ResponsiveBreakpoints.of(context).isTablet
                              ? 4
                              : 2, // Number of columns based on screen size
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: ResponsiveBreakpoints.of(context).isDesktop
                          ? 0.8
                          : ResponsiveBreakpoints.of(context).isTablet
                              ? 1
                              : 1, // Adjust card size
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<GlobalBloc>()
                              .add(GlobalSelectItemEvent(itemId: items[index].id));
                          onTapItemdetails();
                        },
                        child: CustomCategoryItemWidget(
                          itemModel: items[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
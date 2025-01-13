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
        int rowFactor=(state.items.length/7).ceil();
        int spacingFactor =rowFactor>1?((rowFactor-1)*20):0;
        // Main UI when items are loaded
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                    "Articles :",
                    style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.white),
                  ),
                  const SizedBox(height: 10),
              Container(
                height: rowFactor * 204+ spacingFactor.toDouble()+30,
                width: double.infinity,
              
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
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 15),
                  child: Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveBreakpoints.of(context).isDesktop
                            ? 7
                            : ResponsiveBreakpoints.of(context).isTablet
                                ? 4
                                : 2, // Number of columns based on screen size
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: ResponsiveBreakpoints.of(context).isDesktop
                            ? 1
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

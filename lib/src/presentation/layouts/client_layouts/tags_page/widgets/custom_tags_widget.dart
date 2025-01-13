import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/data/models/tag_model.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

import '../../../../shared/constants/app_colors.dart';

class CustomItemWidget extends StatefulWidget {
  const CustomItemWidget({
    super.key,
    required this.tag,
    required this.onTapCategory,
  });

  final TagModel tag;
  final VoidCallback onTapCategory;

  @override
  State<CustomItemWidget> createState() => _CustomItemWidgetState();
}

class _CustomItemWidgetState extends State<CustomItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context.read<GlobalBloc>().add(GlobalGetAllItemsEvent(
                query: {'TagId': widget.tag.id, 'CarModelId': state.selectedCarModelId}));
            widget.onTapCategory();
          },
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              //alignment: Alignment.center, // Ensure scaling is centered
              transform: Matrix4.identity()
                ..translate(0.0, 0.0, _isHovered ? 30.0 : 0.0) // Z-axis effect
                ..scale(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0), // Uniform scaling
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.widgetBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: _isHovered
                          ? Colors.grey.withOpacity(0.5) // Stronger shadow on hover
                          : Colors.grey.withOpacity(0.3),
                      spreadRadius: _isHovered ? 4 : 2,
                      blurRadius: _isHovered ? 10 : 5,
                      offset: const Offset(0, 4), // Shadow direction
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image of the category
                    Image.network(
                      '$baseUrl${widget.tag.imageUrl}',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    // Title of the category
                    Text(
                      widget.tag.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

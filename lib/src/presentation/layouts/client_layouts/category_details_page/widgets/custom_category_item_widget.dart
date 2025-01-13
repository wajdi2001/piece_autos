// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/data/models/item_model.dart';

import '../../../../shared/constants/app_colors.dart';

class CustomCategoryItemWidget extends StatefulWidget {
  final ItemModel itemModel;
  const CustomCategoryItemWidget({
    super.key,
    required this.itemModel,
  });

  @override
  State<CustomCategoryItemWidget> createState() => _CustomCategoryItemWidgetState();
}

class _CustomCategoryItemWidgetState extends State<CustomCategoryItemWidget> {
    bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              //alignment: Alignment.center, // Ensure scaling is centered
              transform: Matrix4.identity()
                ..translate(0.0, 0.0, _isHovered ? 30.0 : 0.0) // Z-axis effect
                ..scale(_isHovered ? 1.05 : 1.0, _isHovered ? 1.05 : 1.0),
        decoration: BoxDecoration(
          color: AppColors.widgetBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exemple d'image d'article
            Image.network(
              '$baseUrl${widget.itemModel.images[0]}',
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            // Nom de l'article
             Text(
              widget.itemModel.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            // Prix de l'article
             Text(
              widget.itemModel.price.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

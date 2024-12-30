// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/data/models/item_model.dart';

class CustomCategoryItemWidget extends StatelessWidget {
  final ItemModel itemModel;
  const CustomCategoryItemWidget({
    super.key,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
            '$baseUrl/${itemModel.images[0]}',
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          // Nom de l'article
           Text(
            itemModel.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // Prix de l'article
           Text(
            itemModel.price.toString(),
            style: TextStyle(
              fontSize: 14,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

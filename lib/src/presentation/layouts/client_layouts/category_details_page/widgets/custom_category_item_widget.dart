// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomCategoryItemWidget extends StatelessWidget {
  const CustomCategoryItemWidget({
    super.key,
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
          Image.asset(
            "assets/images/filtre_air.jpeg",
            height: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10),
          // Nom de l'article
          const Text(
            "Nom de l'article",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          // Prix de l'article
          const Text(
            "140.068 TND",
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

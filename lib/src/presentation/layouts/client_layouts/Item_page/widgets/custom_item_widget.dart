// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    required this.category,
    required this.onTapCategory,
  });

  final Map<String, String> category;
  final VoidCallback onTapCategory;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
        context.read<GlobalBloc>().add(GlobalCategoryNavigatorEvent(title:category["title"]!));
            onTapCategory();
      } ,
      child: Container(
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
            // Image de la catégorie
            Image.asset(
              category["image"]!,
              height: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            // Titre de la catégorie
            Text(
              category["title"]!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

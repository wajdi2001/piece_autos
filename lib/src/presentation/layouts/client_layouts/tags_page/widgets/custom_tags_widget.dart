// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/data/models/tag_model.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

class CustomItemWidget extends StatelessWidget {
  const CustomItemWidget({
    super.key,
    required this.tag,
    required this.onTapCategory,
  });

  final TagModel tag;
  final VoidCallback onTapCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context
                .read<GlobalBloc>()
                .add(GlobalGetAllItemsEvent(query: {'TagId': tag.id,'CarModelId':state.selectedCarModelId}));
            onTapCategory();
          },
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
                Image.network(
                  '$baseUrl/${tag.imageUrl}',
                  height: 80,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 10),
                // Titre de la catégorie
                Text(
                  tag.name,
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
      },
    );
  }
}

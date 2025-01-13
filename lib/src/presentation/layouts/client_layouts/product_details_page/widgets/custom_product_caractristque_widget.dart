import 'package:flutter/material.dart';
import 'package:piece_autos/src/data/models/item_model.dart';

import '../../../../shared/constants/app_colors.dart';

class CustomProductCaractristqueWidget extends StatelessWidget {
  final ItemModel itemModel;
  const CustomProductCaractristqueWidget({
    super.key,
    required this.itemModel
  });

  @override
  Widget build(BuildContext context) {

    List<String> descriptionKey = itemModel.description!.keys.toList();
    List<String> descriptionValue = itemModel.description!.values.toList();
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
    color: AppColors.widgetBackground,
        
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView(
        children: [
           Text(
            itemModel.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "Caractéristiques :",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 300,
            width: 400,
            child: ListView.builder(
              itemCount: descriptionKey.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Text(descriptionKey[index],style: TextStyle(fontWeight: FontWeight.bold),),
                  Text( ' : ${descriptionValue[index]}',style: TextStyle(overflow: TextOverflow.ellipsis),),
                ],
              ),),
          ) // Example details
        ],
      ),
    );
  }
}

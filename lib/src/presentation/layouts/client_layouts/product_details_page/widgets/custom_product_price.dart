import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/src/data/models/order_item_model.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/product_details_page/widgets/category_chip.dart';

import '../../../../../data/models/item_model.dart';

class CustomProductPrice extends StatelessWidget {
  final ItemModel itemModel;
  const CustomProductPrice({
    super.key,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
     BoxShadow(
       color: Colors.grey.withAlpha(55),
       blurRadius: 10,
       spreadRadius: 2,
     ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
     Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
          Text(
           itemModel.price.toString(),
           style: TextStyle(
             fontSize: 24,
             fontWeight: FontWeight.bold,
             color: Colors.black,
           ),
         ),
         Container(
           padding: const EdgeInsets.symmetric(
               horizontal: 12, vertical: 4),
           decoration: BoxDecoration(
             color: Colors.green.shade100,
             borderRadius: BorderRadius.circular(20),
           ),
           child:  Text(
             itemModel.status ==ItemStatus.available?"En Stock":itemModel.status ==ItemStatus.notAvailable?"Hors Stock": "Soon Stock",
             style: TextStyle(
               color: Colors.green,
               fontWeight: FontWeight.bold,
             ),
           ),
         ),
       ],
     ),
     const SizedBox(height: 16),
      Text("Référence: ${itemModel.ref}"),
      Text("Fabricant: ${itemModel.brandId}"),
     
     const SizedBox(height: 16),
     Row(
       children: [
         // Add to Cart Button
         Expanded(
           child: ElevatedButton(
             onPressed: () {

              context.read<GlobalBloc>().add(GlobalAddToShoppingCartEvent(item: OrderItemModel(id: "sdxvfbgfngfbrsfvxc", itemId: itemModel.id, quantity: 1)));
             },
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.blue,
               padding: const EdgeInsets.symmetric(vertical: 16),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10),
               ),
             ),
             child: const Text(
               "Ajouter au panier",
               style: TextStyle(fontSize: 16),
             ),
           ),
         ),
         const SizedBox(width: 16),
         // Add to Favorites Button
         IconButton(
           onPressed: () {},
           icon: const Icon(Icons.favorite_border),
           color: Colors.grey,
         ),
       ],
     ),
      const SizedBox(height: 24),
                  // Associated Categories
                  const Text(
                    "Catégories associées:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      CategoryChip(label: "Silent-bloc de triangle"),
                      CategoryChip(label: "Suspension et bras"),
                    ],
                  ),
                      ],
                    ),
                  );
  }
}

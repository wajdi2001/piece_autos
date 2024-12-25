import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/product_details_page/widgets/category_chip.dart';

class CustomProductPrice extends StatelessWidget {
  const CustomProductPrice({
    super.key,
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
         const Text(
           "22.483 DT",
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
           child: const Text(
             "En Stock",
             style: TextStyle(
               color: Colors.green,
               fontWeight: FontWeight.bold,
             ),
           ),
         ),
       ],
     ),
     const SizedBox(height: 16),
     const Text("Référence: 2250038"),
     const Text("Fabricant: SASIC"),
     const Text("EAN: 3660872478573"),
     const SizedBox(height: 16),
     Row(
       children: [
         // Add to Cart Button
         Expanded(
           child: ElevatedButton(
             onPressed: () {},
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

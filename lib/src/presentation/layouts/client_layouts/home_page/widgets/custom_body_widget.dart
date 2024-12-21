import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';
import 'package:piece_autos/src/presentation/shared/library/searchble_drop_down/searchable_paginated_dropdown.dart';

class CustomBodyWidget extends StatelessWidget {
  final VoidCallback onPressed;

   CustomBodyWidget({
    super.key,
    required this.onPressed,
    
  });

  final List<String> itemsBrands = ['Citroën', 'Dacia', 'Nissan', 'Peugeot'];
    final List<String> itemsModels = [
      'C3',
      'Dacia Sandero',
      'Nissan GTR',
      'Peugeot 208'
    ];
    final List<String> itemsYears = ['2022', '2023', '2024', '2025'];
    final List<String> itemsMotorizations = ['1.2', '1.4', '1.6', '1.8'];

  @override
  Widget build(BuildContext context) {
    return Stack(
       children: [
         Center(
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   'Trouvez des pièces pour votre véhicule',
                   style: TextStyle(
                     fontSize: 24,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                   textAlign: TextAlign.center,
                 ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: -0.2, end: 0),
                 SizedBox(height: 20),
                 Column(
                   spacing: 10,
                   children: [
                     Row(
                       spacing: 10,
                       mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                       children: [
                         // Dropdown for "Choisir la marque"
                         Expanded(
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius:
                                   BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                               color: Colors.white,
                             ),
                             child: SearchableDropdown<String>(
                                
                               dialogOffset: 0.2,
                               isDialogExpanded: false,
                               searchHintText: "Saisir la marque",
                               hintText: Text("Choisir la marque"),
                               items: List.generate(
                                   itemsBrands.length,
                                   (i) =>
                                       SearchableDropdownMenuItem(
        
                                           value: itemsBrands[i],
                                           label: itemsBrands[i],
                                           child: Text(
                                               itemsBrands[i]))),
                             ),
                           ),
                         ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: -0.2, end: 0),
        
                         Expanded(
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius:
                                   BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                               color: Colors.white,
                             ),
                             child: SearchableDropdown<String>(
                               dialogOffset: 0.2,
                               searchHintText: "Saisir le modèle",
                               isDialogExpanded: false,
                               hintText: Text("Choisir le modèle"),
                               items: List.generate(
                                   itemsModels.length,
                                   (i) =>
                                       SearchableDropdownMenuItem(
                                           value: itemsModels[i],
                                           label: itemsModels[i],
                                           child: Text(
                                               itemsModels[i]))),
                             ),
                           ),
                         ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: -0.2, end: 0),
                       ],
                     ),
                     Row(
                       spacing: 10,
                       mainAxisAlignment:
                           MainAxisAlignment.spaceBetween,
                       children: [
                         // Dropdown for "Année"
                         Expanded(
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius:
                                   BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                               color: Colors.white,
                             ),
                             child: SearchableDropdown<String>(
                               dialogOffset: 0.2,
                               searchHintText: "Saisir l'année",
                               isDialogExpanded: false,
                               hintText: Text("Année"),
                               items: List.generate(
                                   itemsYears.length,
                                   (i) =>
                                       SearchableDropdownMenuItem(
                                           value: itemsYears[i],
                                           label: itemsYears[i],
                                           child: Text(
                                               itemsYears[i]))),
                             ),
                           ),
                         ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: -0.2, end: 0),
        
                         Expanded(
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius:
                                   BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                               color: Colors.white,
                             ),
                             child: SearchableDropdown<String>(
                               dialogOffset: 0.2,
                               isDialogExpanded: false,
                               hintText: Text("Motorisation"),
                               items: List.generate(
                                   itemsMotorizations.length,
                                   (i) =>
                                       SearchableDropdownMenuItem(
                                           value:
                                               itemsMotorizations[
                                                   i],
                                           label:
                                               itemsMotorizations[
                                                   i],
                                           child: Text(
                                               itemsMotorizations[
                                                   i]))),
                             ),
                           ),
                         ).animate().fadeIn(duration: 600.ms, delay: 100.ms).slideY(begin: -0.2, end: 0),
                       ],
                     )
                   ],
                 ),
                 SizedBox(height: 10),
                 Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     color: Colors.grey.shade300,
                   ),
                   width: 200,
                   height: 50,
                   child: TextButton(
                     onPressed: onPressed,
                     child: Center(
                         child: Text(
                       "Valider",
                       style: TextStyle(
                           color: AppColors.theardingColor,
                           fontFamily: "Montserrat",
                           fontSize: 20,
                           fontWeight: FontWeight.bold),
                     )),
                   ),
                 ),
                 SizedBox(height: 20),
                 Text(
                   'Recherche par immatriculation',
                   style: TextStyle(
                     fontSize: 16,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                   ),
                 ),
                 SizedBox(height: 10),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Radio(
                       value: 1,
                       groupValue: 1,
                       onChanged: (value) {},
                       activeColor: Colors.white,
                     ),
                     Text(
                       'TU',
                       style: TextStyle(color: Colors.white),
                     ),
                     SizedBox(width: 10),
                     Radio(
                       value: 2,
                       groupValue: 1,
                       onChanged: (value) {},
                       activeColor: Colors.white,
                     ),
                     Text(
                       'RS',
                       style: TextStyle(color: Colors.white),
                     ),
                   ],
                 ),
                 SizedBox(
                   width: 200,
                   child: TextFormField(
                     textAlign: TextAlign.center,
                     decoration: InputDecoration(
                       hintText: '*** تونس ***',
                       filled: true,
                       fillColor: Colors.white,
                       contentPadding: EdgeInsets.symmetric(
                         horizontal: 10,
                         vertical: 5,
                       ),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(8),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(height: 10),
                 ElevatedButton(
                   onPressed: () {},
                   child: Text("Rechercher"),
                 )
               ],
             ),
           ),
         ),
       
       ],
     );
  }
}

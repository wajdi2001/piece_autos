import 'package:flutter/material.dart';

class CustomProductCaractristqueWidget extends StatelessWidget {
  const CustomProductCaractristqueWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
    
        
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Suspension, bras de liaison",
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
          const Text("• Côté d'assemblage: Essieu avant"),
          const Text("• Diamètre intérieur (mm): 12"),
          const Text("• Diamètre extérieur (mm): 36"),
          const Text(
              "• Pour numéro OE: Part of 9831626480"), // Example details
        ],
      ),
    );
  }
}

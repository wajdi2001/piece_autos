import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/service_widget_item.dart';

class ServiceWidget extends StatelessWidget {
  const ServiceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color.fromARGB(180, 255, 255, 255), const Color.fromARGB(180, 255, 255, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ServiceWidgetItem(
            icon: Icons.delivery_dining,
            title: "Livraison gratuite",
            description: [
              "à partir de 100€ d'achat",
              "Livraison en 2-3 jours ouvrables"
            ],
          ),
          ServiceWidgetItem(
            icon: Icons.local_mall,
            title: "Retour gratuit",
            description: [
              "30 jours pour retourner",
              "votre commande",
            ],
          ),
          ServiceWidgetItem(
            icon: Icons.card_membership,
            title: "Paiement sécurisé",
            description: [
              "Paiement sécurisé",
              "par carte bancaire",
            ],
          ),
        ],
      ),
    );
  }
}

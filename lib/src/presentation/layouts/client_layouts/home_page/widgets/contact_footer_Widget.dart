import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactFooter extends StatelessWidget {
  const ContactFooter({super.key});

  @override
  Widget build(BuildContext context) {

    // Define layout breakpoints
    final isMobile = ResponsiveBreakpoints.of(context).isMobile || ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section: Contact Info, Information, and Social Links
          isMobile
              ? _buildMobileLayout()
              : _buildDesktopLayout(),
          const SizedBox(height: 24),
          // Bottom Section: Copyright
          Divider(color: Colors.grey[700]),
          const SizedBox(height: 8),
          Text(
            "Powered by Shadow & Tenzo",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "© 2024 Tous droits réservés.",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContactInfo(),
        const SizedBox(height: 16),
        _buildInformationLinks(),
        const SizedBox(height: 16),
        _buildAccountLinks(),
        const SizedBox(height: 16),
        _buildSocialLinks(),
      ],
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildContactInfo()),
        const SizedBox(width: 16),
        Expanded(child: _buildInformationLinks()),
        const SizedBox(width: 16),
        Expanded(child: _buildAccountLinks()),
        const SizedBox(width: 16),
        Expanded(child: _buildSocialLinks()),
      ],
    );
  }

  // Contact Info Section
  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contactez-nous",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Besoin d'aide ou d'informations?",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.phone, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Text(
              "(+216) 12 345 678",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.email, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Text(
              "test.tn@gmail.com",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Djerba ,Oued Zebib Srandi 4182",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.blue, size: 20),
            const SizedBox(width: 8),
            Text(
              "Lun-Ven: 08:00 - 18:00 | Sam: 08:00 - 14:00",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Information Links Section
  Widget _buildInformationLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Information",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "À propos de nous",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Termes et conditions",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Contactez-nous",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Adresse",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  // Account Links Section
  Widget _buildAccountLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mon Compte",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Éditer le profil",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Historique des commandes",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Wish List",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  // Social Links Section
  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Suivez-nous dans les réseaux sociaux!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.facebook, color: Colors.blue),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.facebook_sharp, color: Colors.lightBlue),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.facebook_outlined, color: Colors.purple),
            ),
          ],
        ),
      ],
    );
  }
}

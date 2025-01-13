import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ContactFooter extends StatelessWidget {
  const ContactFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile || 
                    ResponsiveBreakpoints.of(context).isTablet;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Layout principal qui change selon la taille de l'écran
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          const SizedBox(height: 24),
          Divider(color: Colors.grey[700]),
          const SizedBox(height: 8),
          // Section copyright qui reste la même pour les deux layouts
          _buildCopyright(),
        ],
      ),
    );
  }

  // Layout Mobile - Organisation verticale
  Widget _buildMobileLayout() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactInfo(),
          const SizedBox(height: 32),
          _buildInformationLinks(),
          const SizedBox(height: 32),
          _buildAccountLinks(),
          const SizedBox(height: 32),
          _buildSocialLinks(),
        ],
      ),
    );
  }

  // Layout Desktop - Organisation horizontale
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _buildContactInfo(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: _buildInformationLinks(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 2,
          child: _buildAccountLinks(),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 3,
          child: _buildSocialLinks(),
        ),
      ],
    );
  }

  Widget _buildCopyright() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
    );
  }

  Widget _buildContactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Contactez-nous",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.footerTextColor,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactItem(Icons.phone, "(+216) 12 345 678"),
        _buildContactItem(Icons.email, "test.tn@gmail.com"),
        _buildContactItem(Icons.location_on, "Djerba, Oued Zebib Srandi 4182"),
        _buildContactItem(
          Icons.access_time, 
          "Lun-Ven: 08:00 - 18:00 | Sam: 08:00 - 14:00"
        ),
      ],
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.footerLinkColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.footerTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Information",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.footerTextColor,
          ),
        ),
        const SizedBox(height: 16),
        FooterLink(text: "À propos de nous"),
        FooterLink(text:"Termes et conditions"),
        FooterLink(text:"Contactez-nous"),
        FooterLink(text:"Adresse"),
      ],
    );
  }

  Widget _buildAccountLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Mon Compte",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.footerTextColor,
          ),
        ),
        const SizedBox(height: 16),
        FooterLink(text:"Éditer le profil"),
        FooterLink(text:"Historique des commandes"),
        FooterLink(text:"Wish List"),
      ],
    );
  }


  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          "Suivez-nous sur les réseaux sociaux!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSocialButton(Icons.facebook, Colors.blue),
            const SizedBox(width: 8),
            _buildSocialButton(Icons.telegram, Colors.lightBlue),
            const SizedBox(width: 8),
            _buildSocialButton(Icons.facebook, Colors.purple),
            const SizedBox(width: 8),
            _buildSocialButton(Icons.youtube_searched_for, Colors.red),
          ],
        ),
        
      ],
    );
  }

  Widget _buildSocialButton(IconData icon, Color color) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: color),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

 }




class FooterLink extends StatefulWidget {
  final String text;

  const FooterLink({super.key, required this.text});

  @override
  _FooterLinkState createState() => _FooterLinkState();
}

class _FooterLinkState extends State<FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
          border: _isHovered
              ? Border(
                  bottom: BorderSide(
                    color: AppColors.footerLinkColor, // Hover underline color
                    width: 2.0,
                  ),
                )
              : null,
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 14,
            color: _isHovered
                ? AppColors.footerLinkColor // Highlight text color on hover
                : AppColors.footerTextColor, // Default text color
            letterSpacing: _isHovered ? 1.2 : 1.0, // Subtle letter spacing animation
          ),
        ),
      ),
    );
  }
}

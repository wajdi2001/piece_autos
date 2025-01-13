import 'package:flutter/material.dart';
import '../utility/hex_color.dart';

class AppColors {
  // Couleurs principales
  static Color primaryColor = Color(0xFF00bcd4);    // Noir (fond)
  static Color secondaryColor = HexColor("#00bcd4");   // Jaune (chiffre 9)
  static Color accentColor = HexColor("#0066FF");     // Bleu (aiguille)
  
  // Couleurs supplémentaires
  static Color greyColor = HexColor("#808080");       // Gris (compteur)
  static Color whiteColor = HexColor("#FFFFFF");      // Blanc (texte)
  
  // Variantes de transparence
  static Color blackOverlay = Colors.black.withOpacity(0.7);
  static Color yellowOverlay = secondaryColor.withOpacity(0.1);



    // Dégradés principaux

  static LinearGradient mainGradient =  LinearGradient(
              colors: [
                Color(0xFF1a1a40), // Dark navy blue
                Color(0xFF00bcd4), // Vibrant cyan
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            );

  // Dégradé premium
  static LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      HexColor("#000000"),        // Noir
      HexColor("#1a1a1a"),        // Noir profond
      HexColor("#262626"),        // Gris très foncé
    ],
  );

  // Dégradé accent
  static LinearGradient accentGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      HexColor("#000000"),        // Noir
      HexColor("#1a1a1a"),        // Noir profond
      HexColor("#0066FF").withOpacity(0.3),  // Bleu avec opacité
    ],
  );

  // Dégradé pour les cartes
  static LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      HexColor("#1a1a1a"),        // Noir profond
      HexColor("#262626"),        // Gris très foncé
      HexColor("#FFD700").withOpacity(0.05),  // Jaune très subtil
    ],
  );


  static Color primaryButtonColor = secondaryColor; // Yellow (#FFD700)
static Color primaryButtonTextColor = whiteColor; // White (#FFFFFF)
static LinearGradient homeBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    HexColor("#1a1a1a"), // Dark gray
    HexColor("#000000"), // Black
  ],
);
static Color widgetBackground = Colors.white; // Light gray
static Color widgetShadow = Colors.black.withOpacity(0.1); // Subtle shadow



static Color titleTextColor = whiteColor; // White (#FFFFFF)
static Color subtitleTextColor = greyColor; // Gray (#808080)
static Color inputTextColor = whiteColor; // White (#FFFFFF)


static Color footerBackground = Color(0xFF1C1C1E); // Black (#000000)
static Color footerTextColor = Color.fromARGB(255, 255, 255, 255); // Gray (#808080)
static Color footerLinkColor = Color(0xFF00C8C8); // Yellow (#FFD700)



static Color socialIconColor = whiteColor; // White (#FFFFFF)


}

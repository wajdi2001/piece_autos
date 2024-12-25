import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Top AppBar Section
          Container(
            padding: const EdgeInsets.all(8),
            height: 75,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: AppColors.primaryRedColor,
            ),
            child: ResponsiveBreakpoints.of(context).isDesktop
                ? Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Huiles et additifs",
                          style: _menuItemStyle(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Embrayages",
                          style: _menuItemStyle(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Accessoires",
                          style: _menuItemStyle(),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container
                        (
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/pieceAutoLogo.png'),fit: BoxFit.scaleDown  )
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Mon compte",
                          style: _menuItemStyle(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Panier",
                          style: _menuItemStyle(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "A propos",
                          style: _menuItemStyle(),
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.menu, color: Colors.white),
                      ),
                      
                      Container
                        (
                          height: 50,
                          width: 75,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/pieceAutoLogo.png',),fit: BoxFit.contain,)
                          ),
                        ),
                    ],
                  ),
          ),
          const SizedBox(height: 10),
          // Search Section
          Column(
            children: [
              const Text(
                'Rechercher une pièce',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Entrer la référence ou la pièce',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _menuItemStyle() {
    return TextStyle(
      color: AppColors.theardingColor,
      fontFamily: "Montserrat",
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
  }
}

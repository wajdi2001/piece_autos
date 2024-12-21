import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';

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
          Container(
             padding: EdgeInsets.all(8),
      height:75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppColors.primaryRedColor,
      ),
            child: Row(
              children: 
              [
                Expanded(child: Text("Huiles et additifs",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                Expanded(child: Text("Embrayages",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                Expanded(child: Text("Accessoires",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                Expanded(flex: 3,child: Center(child: Text("logo",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),),
                Expanded(child: Text("Mon compte",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                Expanded(child: Text("Panier",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                Expanded(child: Text("A propos",style: TextStyle(color: AppColors.theardingColor,fontFamily: "Montserrat",fontSize: 15,fontWeight: FontWeight.bold),)),
                
              
              ],
            ),
          ),
          SizedBox(height: 10,),
            Column(
        children: [
          Text(
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
        ],
      ),
             
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(8),
      height:75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
    );
  }
}
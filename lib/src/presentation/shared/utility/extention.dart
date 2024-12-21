import 'package:flutter/material.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/Item_page/item_page.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/home_page/widgets/custom_body_widget.dart';

extension IntExtension on int {
  Widget getHomePageBody()
  {
    if(this  == 0){
      return   CustomBodyWidget(onPressed: () {
        
      },);
    }else if(this  == 1){
      return const ItemPage();
    }else{
      return  Container();
    }
  }
  }
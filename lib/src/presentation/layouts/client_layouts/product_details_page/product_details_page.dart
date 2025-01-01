import 'package:flutter/material.dart';
import 'package:piece_autos/src/data/models/item_model.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/product_details_page/widgets/custom_product_caractristque_widget.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/product_details_page/widgets/custom_product_image_thumbnail_widget.dart';
import 'package:piece_autos/src/presentation/layouts/client_layouts/product_details_page/widgets/custom_product_price.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'widgets/custom_product_description.dart';

class ProductDetailPage extends StatelessWidget {
  final ItemModel itemModel;
  const ProductDetailPage({super.key,required this.itemModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1500, 
                width: double.infinity,
                margin: EdgeInsets.all(10),
                decoration:BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.white.withAlpha(128), // 50% opacity
      Colors.white.withAlpha(77),// More transparent white
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color:  Colors.white.withAlpha(128), // 50% opacity
      
      width: 1.5,
    ),
  ),
      
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(ResponsiveBreakpoints.of(context).isMobile||ResponsiveBreakpoints.of(context).isPhone||ResponsiveBreakpoints.of(context).isTablet)
            Container(
            margin: EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:  Text(
                        itemModel.name,
                        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
                        ),
                      ),
                        ),
            // Product Image and Thumbnail
            Expanded(
              flex:ResponsiveBreakpoints.of(context).isMobile||ResponsiveBreakpoints.of(context).isPhone||ResponsiveBreakpoints.of(context).isTablet?1: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main Image
                  Expanded(
                    flex: 2,
                    child: 
                    Container(
                      margin:ResponsiveBreakpoints.of(context).isMobile||ResponsiveBreakpoints.of(context).isPhone||ResponsiveBreakpoints.of(context).isTablet? EdgeInsets.symmetric(vertical: 8):EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: 
                        [
                          Expanded(
                            flex: 2,
                            child: 
                          CustomProductImageThumbnailWidget(images: itemModel.images,),
                          ),
                          if(ResponsiveBreakpoints.of(context).isDesktop)
                          Expanded(
                            flex: 2,
                            child: 
                          CustomProductCaractristqueWidget(itemModel: itemModel,),
                          )
                        ],
                      ),
                    )
                    
                  ),

                  ///desktop Price Display
                  if(ResponsiveBreakpoints.of(context).isDesktop)
                  Expanded(child: 
                   CustomProductPrice(itemModel: itemModel,),
              )
                ],
              ),
            ),
        ///mobile Price Display
           if(ResponsiveBreakpoints.of(context).isMobile||ResponsiveBreakpoints.of(context).isPhone||ResponsiveBreakpoints.of(context).isTablet)
                  Expanded(
                    flex: 1,
                    child: 
                   CustomProductPrice(itemModel: itemModel,),
              ),

            // Price and Stock Information
            Expanded(
              flex: 1,
              child: 
            CustomProductDescrpitionWidget())


          
          ],
        ),
      ),
    
    );
  }
}

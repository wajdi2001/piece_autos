import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/core/utils/cache_helper.dart';
import 'package:piece_autos/src/data/models/order_item_model.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

import '../../../../../data/models/brand_model.dart';
import '../../../../../data/models/item_model.dart';
import '../../../../shared/constants/app_colors.dart';

class CustomProductPrice extends StatelessWidget {
  final ItemModel itemModel;
  const CustomProductPrice({
    super.key,
    required this.itemModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        String brandName = CacheHelper.getObjectList(
                key: "brands",
                fromJson: (jsonString) => BrandModel.fromJson1(jsonString))
            .where((e) => e.id == itemModel.brandId)
            .first
            .name;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.widgetBackground,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha(55),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemModel.price.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      itemModel.status == ItemStatus.available
                          ? "En Stock"
                          : itemModel.status == ItemStatus.notAvailable
                              ? "Hors Stock"
                              : "Soon Stock",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text("Référence: ${itemModel.ref}"),
              Text("Fabricant: $brandName"),
const Spacer(),
              Row(
                children: [
                  // Add to Cart Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<GlobalBloc>().add(
                            GlobalAddToShoppingCartEvent(
                                item: OrderItemModel(
                                    id: "sdxvfbgfngfbrsfvxc",
                                    itemId: itemModel.id,
                                    quantity: 1)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButtonColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:  Text(
                        "Ajouter au panier",
                        style: TextStyle(fontSize: 16, color: AppColors.primaryButtonTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Add to Favorites Button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite_border),
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

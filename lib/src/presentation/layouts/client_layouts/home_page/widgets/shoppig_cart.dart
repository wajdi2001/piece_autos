import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/cache_helper.dart';
import 'package:piece_autos/core/utils/constants.dart';
import '../../../../../data/models/item_model.dart';
import '../../../../../data/models/order_item_model.dart';
import '../../../../controllers/global_bloc/global_bloc.dart';
import '../../../../shared/utility/methodes.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ShoppingCartDrawer extends StatelessWidget {
  final List<OrderItemModel> cartItems;
  final VoidCallback onCheckout;

  const ShoppingCartDrawer({
    super.key,
    required this.cartItems,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    // Fetch items from cache once
    final List<ItemModel> items = CacheHelper.getObjectList(
      key: "items",
      fromJson: (json) => ItemModel.fromJson1(json),
    );

    return Drawer(
      width: 350,
      child: Container(
        color: Colors.white,
        child: SizedBox(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                color: Colors.grey[800],
                child: const Text(
                  'Panier',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
        
              // Cart Items
              Expanded(
                child: cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          'Your cart is empty!',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartItems[index];
        
                          // Find the corresponding ItemModel
                          final itemModel = items.firstWhere(
                            (i) => i.id == item.itemId,
                          );
        
                          // Construct image URL
                          final imageUrl = itemModel.images.isNotEmpty
                              ? '$baseUrl${itemModel.images.first}'
                              : '';
        
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(55),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(55),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),

                                ],
                              ),
                              child: ListTile(
                                leading: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                title: Text(
                                  itemModel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Row(
                                  children: [
                                    // Decrease Quantity Button
                                    IconButton(
                                      icon:
                                          const Icon(Icons.remove_circle_outline),
                                      onPressed: () {
                                        if (item.quantity > 1) {
                                          context.read<GlobalBloc>().add(
                                                GlobalUpdateShoppingCartEvent(
                                                  remove: false,
                                                  item: OrderItemModel(
                                                    id: item.id,
                                                    itemId: item.itemId,
                                                    quantity: item.quantity - 1,
                                                  ),
                                                ),
                                              );
                                        }
                                      },
                                    ),
        
                                    // Quantity Text
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
        
                                    // Increase Quantity Button
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      onPressed: () {
                                        context.read<GlobalBloc>().add(
                                              GlobalUpdateShoppingCartEvent(
                                                remove: false,
                                                item: OrderItemModel(
                                                  id: item.id,
                                                  itemId: item.itemId,
                                                  quantity: item.quantity + 1,
                                                ),
                                              ),
                                            );
                                      },
                                    ),
        
                                    const Spacer(),
        
                                    // Item Price
                                    Text(
                                      ' ${(itemModel.price * item.quantity).toStringAsFixed(2)} DT',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
        
                                // Remove Item Button
                                trailing: IconButton(
                                  icon:
                                      const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    context.read<GlobalBloc>().add(
                                          GlobalUpdateShoppingCartEvent(
                                            remove: true,
                                            item: item,
                                          ),
                                        );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
        
              // Total Price and Checkout Button
              if (cartItems.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Total Price
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${_calculateTotalPrice(cartItems, items).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
        
                      // Checkout Button
                      BlocBuilder<GlobalBloc, GlobalState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                /* context
                                    .read<GlobalBloc>()
                                    .add(GlobalGetAllTVAEvent());*/
        
                                final pdf = await generateTicketPDF(
                                  cartItems: cartItems,
                                  items: items,
                                );
        
                                final bytes = await pdf.save();
                                if (kIsWeb) {
                                  savePDFWeb(bytes);
                                } else {
                                  try {
                                   await savePDF(bytes);
                                  } catch (e) {
                                    print("Error saving PDF: $e");
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                backgroundColor: Colors.blue,
                              ),
                              child: const Text(
                                'Proceed to Checkout',
                                style: TextStyle(fontSize: 16.0,color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Calculate the total price of items in the cart
  double _calculateTotalPrice(
    List<OrderItemModel> cartItems,
    List<ItemModel> items,
  ) {
    return cartItems.fold(0.0, (total, cartItem) {
      final itemModel = items.firstWhere(
        (i) => i.id == cartItem.itemId,
      );
      return total + (itemModel.price * cartItem.quantity);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/utils/cache_helper.dart';
import 'package:piece_autos/core/utils/constants.dart';
import '../../../../../data/models/item_model.dart';
import '../../../../../data/models/order_item_model.dart';
import '../../../../controllers/global_bloc/global_bloc.dart';

class ShoppingCartDrawer extends StatelessWidget {
  final List<OrderItemModel> cartItems;
  final VoidCallback onCheckout;
  final Function(OrderItemModel) onRemoveItem;

  const ShoppingCartDrawer({
    super.key,
    required this.cartItems,
    required this.onCheckout,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        
        return Container(
          margin: EdgeInsets.only(top: 8,bottom: 8),
          child: Drawer(
            width: 450,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  color: const Color.fromARGB(255, 102, 102, 102),
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
                            'Panier vide!',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            ItemModel items=CacheHelper.getObjectList(key: "items", fromJson: (jsonString) => ItemModel.fromJson1(jsonString)).where((e)=>e.id==item.itemId).first;
                            return ListTile(
                              leading: items.images.isNotEmpty
                                  ? Image.network(
                                      '$baseUrl/${items.images[0]}',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(Icons.image_not_supported),
                              title: Text(
                                items.name,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    'Price: \$${items.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 14.0),
                                  ),
                                  IconButton(icon: Icon(Icons.minimize),onPressed:() {
                                    if(item.quantity>1){
                                      context.read<GlobalBloc>().add(GlobalUpdateShoppingCartEvent(remove: false,item: OrderItemModel(id: item.id, itemId: item.itemId, quantity: item.quantity-1)));
                                    }
                                  } ,),
                                  Text('${item.quantity}'),
                                   IconButton(icon: Icon(Icons.add), onPressed:() {
                                    context.read<GlobalBloc>().add(GlobalUpdateShoppingCartEvent(remove: false,item: OrderItemModel(id: item.id, itemId: item.itemId, quantity: item.quantity+1)));
                                  } ,)
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () 
                                {
                                                                        context.read<GlobalBloc>().add(GlobalUpdateShoppingCartEvent(item: item,remove: true));

                                }, // Remove item
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
                              '\$${_calculateTotalPrice(cartItems).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
          
                        // Checkout Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: onCheckout,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              'Proceed to Checkout',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Calculate the total price of items in the cart
  double _calculateTotalPrice(List<OrderItemModel> items,) {
                              

    return items.fold(
      0.0,
      (total, item) => total + (CacheHelper.getObjectList(key: "items", fromJson: (jsonString) => ItemModel.fromJson1(jsonString)).where((e)=>e.id==item.itemId).first.price * item.quantity),
    );
  }
}

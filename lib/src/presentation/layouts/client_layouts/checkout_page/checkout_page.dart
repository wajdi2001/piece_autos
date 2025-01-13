import 'package:flutter/material.dart';
import 'package:piece_autos/core/utils/cache_helper.dart';
import 'package:piece_autos/src/presentation/shared/constants/app_colors.dart';

import '../../../../data/models/item_model.dart';
import '../../../../data/models/order_item_model.dart';

class CheckoutPage extends StatefulWidget {
  final List<OrderItemModel>? shoppingCart;

  const CheckoutPage({super.key, required this.shoppingCart});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int currentStep = 0; // Tracks the current step
  bool isDelivery = true; // Tracks delivery or pickup
  double deliveryFee = 7.0; // Delivery fee
  final _formKey = GlobalKey<FormState>(); // Form validation key

  // User input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController matriculeController = TextEditingController();
  final TextEditingController telController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          spreadRadius: 3,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stepper(
                      physics:
                          const ClampingScrollPhysics(), // Ensures smooth scrolling
                      currentStep: currentStep,
                      onStepTapped: (index) {
                        setState(() {
                          currentStep = index;
                        });
                      },
                      onStepContinue: () {
                        if (currentStep == 0) {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              currentStep++;
                            });
                          }
                        } else if (currentStep == 1) {
                          // Handle final confirmation
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Commande Confirmé!')),
                          );
                        }
                      },
                      onStepCancel: () {
                        if (currentStep > 0) {
                          setState(() {
                            currentStep--;
                          });
                        }
                      },
                      controlsBuilder: (context, details) {
                        return Row(
                          children: [
                            // Continue Button
                            ElevatedButton(
                              onPressed: details.onStepContinue,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    AppColors.primaryColor, // Custom color
                              ),
                              child: const Text('Continue'),
                            ),
                            const SizedBox(width: 8),
                            // Cancel Button
                            TextButton(
                              onPressed: details.onStepCancel,
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red, // Custom color
                              ),
                              child: const Text('Annuler'),
                            ),
                          ],
                        );
                      },
                      steps: [
                        Step(
                          stepStyle: StepStyle(
                            color: AppColors.primaryColor,
                            connectorColor: AppColors.primaryColor,
                          ),
                          title: const Text('Details'),
                          content: buildStep1(),
                          isActive: currentStep >= 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          stepStyle: StepStyle(
                            color: AppColors.primaryColor,
                            connectorColor: AppColors.primaryColor,
                          ),
                          title: const Text('Récapitulatif'),
                          content: buildStep2(),
                          isActive: currentStep >= 1,
                          state: currentStep == 1
                              ? StepState.editing
                              : StepState.indexed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Step 1: Delivery or Pickup Form
  Widget buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Form Container with Border
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                color: Colors.grey.shade100,
              ),
              child: Column(
                children: [
                  // Grid Layout for Input Fields
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomTextFormFiled(
                            isDelivery: false,
                            controller: nameController,
                           
                              
                              labelText: 'Nom de facturation*',
                              
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomTextFormFiled(
                            isDelivery: false,
                            controller: telController,
                            
                              labelText: 'Tel*',
                              
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CustomTextFormFiled(
                            isDelivery: false,
                            controller: cityController,
                            
                              labelText: 'Ville*',
                             
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomTextFormFiled(
                            isDelivery: false,
                            controller: matriculeController,
                            
                              
                              labelText: 'Matricule',
                              
                            ),
                          ),
                        ),
                      
                    ],
                  ),
                  const SizedBox(height: 16),
                  if(isDelivery)
                    CustomTextFormFiled(controller: addressController, isDelivery: isDelivery,labelText: 'Adresse de livraison*',),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Delivery or Pickup Toggle
            SwitchListTile(
              activeColor: AppColors.primaryColor,
              title: const Text('Delivery'),
              value: isDelivery,
              onChanged: (value) {
                setState(() {
                  isDelivery = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Step 2: Order Summary
  Widget buildStep2() {
    List<ItemModel>itemsList= CacheHelper.getObjectList(key: "items", fromJson: (p0) => ItemModel.fromJson1(p0),);
    double total = widget.shoppingCart?.fold(
          0.0,
          (sum, item) =>
              sum! + (item.quantity * itemsList.where((e)=>e.id==item.itemId).first.price), // Assuming unit price = 50
        ) ??
        0.0;

    if (isDelivery) total += deliveryFee;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Votre commande',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Order Items List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.shoppingCart?.length ?? 0,
            itemBuilder: (context, index) {
              final item = widget.shoppingCart![index];
              return ListTile(
                title: Text('Item: ${itemsList.where((e)=>e.id==item.itemId).first.name}'),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: Text(
                    '${item.quantity * itemsList.where((e)=>e.id==item.itemId).first.price} DT'), // Assuming unit price = 50
              );
            },
          ),

          const SizedBox(height: 10),

          // Total
          Text(
            'Sous-total: ${total - (isDelivery ? deliveryFee : 0)} DT',
            style: const TextStyle(fontSize: 16),
          ),
          if (isDelivery)
            Text(
              'Frais de livraison: $deliveryFee DT',
              style: const TextStyle(fontSize: 16),
            ),
          Text(
            'Total: $total DT',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.controller,
    required this.isDelivery,
    required this.labelText,
  });

  final TextEditingController controller;
  final bool isDelivery;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        hoverColor: AppColors.primaryColor,
        
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) =>
          isDelivery && (value == null || value.isEmpty)
              ? 'Required for delivery'
              : null,
    );
  }
}

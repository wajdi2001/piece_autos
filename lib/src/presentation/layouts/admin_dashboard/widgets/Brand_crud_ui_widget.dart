import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';
import 'package:piece_autos/src/presentation/layouts/admin_dashboard/widgets/image_picker_widget.dart';

class BrandCrudUI extends StatefulWidget {
  const BrandCrudUI({super.key});

  @override
  State<BrandCrudUI> createState() => _BrandCrudUIState();
}

class _BrandCrudUIState extends State<BrandCrudUI> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      sl<GlobalBloc>().add(GlobalGetAllBrandsEvent());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brand Management'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: const BrandTable(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open modal for creating/updating brand
          showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
              value: sl<DashboardBloc>(),
              child: const BrandFormModal(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BrandTable extends StatelessWidget {
  const BrandTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        if (state.status == GlobalStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == GlobalStatus.loaded) {
          final brands = state.brands;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Image')),
                DataColumn(label: Text('Actions')),
              ],
              rows: brands.map((brand) {
                return DataRow(cells: [
                  DataCell(Text(brand.id.toString())),
                  DataCell(Text(brand.name)),
                  DataCell(
                    Image.network(
                      "$baseUrl/${brand.image}",
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.broken_image, size: 50);
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                  DataCell(Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Open modal for editing brand
                          showDialog(
                            context: context,
                            builder: (context) => BrandFormModal(
                              brand: brand,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Handle delete action
                          context
                              .read<GlobalBloc>()
                              .add(GlobalDeleteBrandEvent(brandId: brand.id));
                        },
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          );
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}

class BrandFormModal extends StatefulWidget {
  final dynamic brand; // Pass the brand object for editing, null for adding
  const BrandFormModal({super.key, this.brand});

  @override
  State<BrandFormModal> createState() => _BrandFormModalState();
}

class _BrandFormModalState extends State<BrandFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.brand != null) {
      // Pre-fill the form for editing
      _nameController.text = widget.brand.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.brand == null ? 'Add Brand' : 'Edit Brand'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [ImagePickerWidget()],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Dispatch event to add/update brand
              // Use _nameController.text and _selectedImage for the data
              if (widget.brand == null) {
                // Add new brand
                // context.read<GlobalBloc>().add(
                //       GlobalAddBrandEvent(
                //         name: _nameController.text,
                //         imageFile: _selectedImage,
                //       ),
                //     );
              } else {
                // Update existing brand
                // context.read<GlobalBloc>().add(
                //       GlobalUpdateBrandEvent(
                //         brandId: widget.brand.id,
                //         name: _nameController.text,
                //         imageFile: _selectedImage,
                //       ),
                //     );
              }
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

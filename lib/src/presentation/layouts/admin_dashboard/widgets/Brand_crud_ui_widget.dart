import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
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
          showModalBottomSheet(
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
                      "$baseUrl${brand.image}",
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
  final BrandModel? brand; // Pass the brand object for editing, null for adding
  const BrandFormModal({super.key, this.brand});

  @override
  State<BrandFormModal> createState() => _BrandFormModalState();
}

class _BrandFormModalState extends State<BrandFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.brand != null) {
      // Pre-fill the form for editing
      _nameController.text = widget.brand!.name;
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.brand == null ? 'Add Brand' : 'Edit Brand',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name.';
                        }
                        return null;
                      },
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    ImagePickerWidget(
                      defaultNetworkImage: widget.brand?.image,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Dispatch event to add/update brand
                        context.read<DashboardBloc>().add(
                              DashboardUpsertBrandEvent(
                                name: _nameController.text,
                                brandId: widget.brand?.id,
                              ),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

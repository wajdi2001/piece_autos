import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/core/utils/constants.dart';
import 'package:piece_autos/src/data/models/brand_model.dart';
import 'package:piece_autos/src/domain/entities/brand.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';
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
            child: const ResponsiveDataTable(),
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

class ResponsiveDataTable extends StatelessWidget {
  const ResponsiveDataTable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen =
            constraints.maxWidth < 600; // Adjust breakpoint as needed
        return SingleChildScrollView(
          scrollDirection:
              Axis.horizontal, // Enable horizontal scrolling for small screens
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: BlocBuilder<GlobalBloc, GlobalState>(
              builder: (context, state) {
                final brands = state.brands;
                return DataTable(
                  columnSpacing: isSmallScreen
                      ? 20
                      : 40, // Adjust spacing based on screen size
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Brand Type')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: brands.map((brand) {
                    return DataRow(cells: [
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
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      DataCell(Text(brand.brandType.name)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Open modal for editing brand
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => BlocProvider.value(
                                  value: sl<DashboardBloc>(),
                                  child: BrandFormModal(
                                    brand: brand,
                                  ),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // Handle delete action
                              context.read<GlobalBloc>().add(
                                  GlobalDeleteBrandEvent(brandId: brand.id));
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                );
              },
            ),
          ),
        );
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
      sl<DashboardBloc>().add(DashboardChangeSelectedBrandTypeEvent(
          brandTypeIndex: widget.brand!.brandType));
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
                    Center(
                      child: ImagePickerWidget(
                        defaultNetworkImage: widget.brand != null
                            ? "$baseUrl${widget.brand!.image}"
                            : null,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text("Type:"),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.blueGrey, width: 2),
                              ),
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: BlocBuilder<DashboardBloc,
                                      DashboardState>(
                                    builder: (context, state) {
                                      final bloc = DashboardBloc.get(context);
                                      return DropdownButton(
                                        underline: Container(),
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(5),
                                        items: BrandType.values
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Center(
                                                  child: Text(
                                                    e.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        value: bloc.state.selectedBrandType,
                                        onChanged: (value) => bloc.add(
                                            DashboardChangeSelectedBrandTypeEvent(
                                                brandTypeIndex:
                                                    value as BrandType)),
                                      );
                                    },
                                  ))),
                        ),
                      ],
                    )
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
                    child: Text(widget.brand != null ? 'Edit' : 'Save'),
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

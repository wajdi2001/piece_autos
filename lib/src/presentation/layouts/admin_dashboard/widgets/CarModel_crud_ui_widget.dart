import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/enums.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/src/data/models/data_car_model.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_state.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

class CarModelCrudUI extends StatefulWidget {
  const CarModelCrudUI({super.key});

  @override
  State<CarModelCrudUI> createState() => _CarModelCrudUIState();
}

class _CarModelCrudUIState extends State<CarModelCrudUI> {
  @override
  void initState() {
    sl<GlobalBloc>().add(GlobalGetAllCarModelEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open modal for creating/updating brand
          showModalBottomSheet(
            context: context,
            builder: (context) => BlocProvider.value(
              value: sl<DashboardBloc>(),
              child: const CarModelFormModal(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Car Model Management',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: CarModelTable(),
          ),
        ],
      ),
    );
  }
}

class CarModelTable extends StatelessWidget {
  const CarModelTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        if (state.status == GlobalStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == GlobalStatus.loaded) {
          final carModels = state.carModels;
          final bloc = GlobalBloc.get(context);
          return DataTable(
            columns: const [
              // DataColumn(label: Text('ID')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Year of Construction')),
              DataColumn(label: Text('Brand Name')),
              DataColumn(label: Text('Actions')),
            ],
            rows: carModels.map((carModel) {
              return DataRow(cells: [
                // DataCell(Text(carModel.id)),
                DataCell(Text(carModel.name)),
                DataCell(Text(carModel.yearOfConstruction.toString())),
                DataCell(Text(bloc.getBrandNameById(carModel.brandId) ?? "")),
                DataCell(Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: sl<DashboardBloc>(),
                              child: CarModelFormModal(
                                carModel: carModel,
                              ),
                            ),
                          );
                        }),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => sl<GlobalBloc>().add(
                        GlobalDeleteCarModelEvent(carModelId: carModel.id),
                      ),
                    ),
                  ],
                )),
              ]);
            }).toList(),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class CarModelFormModal extends StatefulWidget {
  final DataCarModel?
      carModel; // Pass the brand object for editing, null for adding
  const CarModelFormModal({super.key, this.carModel});

  @override
  State<CarModelFormModal> createState() => _CarModelFormModalState();
}

class _CarModelFormModalState extends State<CarModelFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearOfConstruction = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.carModel != null) {
      // Pre-fill the form for editing
      _nameController.text = widget.carModel!.name;
      _yearOfConstruction.text = widget.carModel!.yearOfConstruction.toString();
      sl<DashboardBloc>().add(
          DashboardChangeSelectedBrandEvent(brandId: widget.carModel!.brandId));
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _nameController.dispose();
    _yearOfConstruction.dispose();
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
                widget.carModel == null ? 'Add CarModel' : 'Edit CarModel',
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
                    TextFormField(
                      controller: _yearOfConstruction,
                      decoration: const InputDecoration(
                        labelText: 'Year of construction',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the year of construction.';
                        }

                        // Check if the input is a valid number
                        final year = int.tryParse(value);
                        if (year == null) {
                          return 'Please enter a valid number.';
                        }

                        // Check if the year is within a valid range
                        final currentYear = DateTime.now().year;
                        if (year < 1800 || year > currentYear) {
                          return 'Please enter a year between 1800 and $currentYear.';
                        }

                        return null;
                      },
                      keyboardType:
                          TextInputType.number, // Ensure numeric input
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blueGrey, width: 2),
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: BlocBuilder<DashboardBloc, DashboardState>(
                              builder: (context, state) {
                                final bloc = DashboardBloc.get(context);
                                return DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(5),
                                  items: [
                                    ...sl<GlobalBloc>().state.brands.map(
                                          (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Center(
                                              child: Text(
                                                e.name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                    DropdownMenuItem(
                                      value: "NONE",
                                      child: Center(
                                        child: Text(
                                          "Aucun",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                  value: bloc.state.selectedBrandId,
                                  onChanged: (value) => bloc.add(
                                      DashboardChangeSelectedBrandEvent(
                                          brandId: value)),
                                );
                              },
                            )))
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
                      if (_formKey.currentState!.validate() &&
                          context.read<DashboardBloc>().state.selectedBrandId !=
                              "NONE") {
                        // Dispatch event to add/update brand
                        context.read<DashboardBloc>().add(
                              DashboardUpsertCarModelEvent(
                                yearOfConstruction:
                                    int.parse(_yearOfConstruction.text),
                                carModelId: widget.carModel?.id,
                                name: _nameController.text,
                              ),
                            );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(widget.carModel != null ? 'Edit' : 'Save'),
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

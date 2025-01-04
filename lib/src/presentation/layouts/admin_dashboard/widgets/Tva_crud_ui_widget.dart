import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:piece_autos/core/services/injection_container.dart';
import 'package:piece_autos/src/data/models/tva_model.dart';
import 'package:piece_autos/src/presentation/controllers/dashboard/dashboard_bloc.dart';
import 'package:piece_autos/src/presentation/controllers/global_bloc/global_bloc.dart';

class TVACrudUI extends StatefulWidget {
  const TVACrudUI({super.key});

  @override
  State<TVACrudUI> createState() => _TVACrudUIState();
}

class _TVACrudUIState extends State<TVACrudUI> {
  @override
  void initState() {
    sl<GlobalBloc>().add(GlobalGetAllTVAEvent());
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
              child: const TvaFormModal(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TVA Management',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: TVATable(),
          ),
        ],
      ),
    );
  }
}

class TVATable extends StatelessWidget {
  const TVATable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        final tvas = state.tvas;

        return LayoutBuilder(
          builder: (context, constraints) {
            final isSmallScreen = constraints.maxWidth < 600;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: DataTable(
                  columnSpacing:
                      isSmallScreen ? 20 : 40, // Adjust spacing dynamically
                  columns: const [
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Percentage')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: tvas
                      .map((elt) => DataRow(cells: [
                            DataCell(Text(elt.name)),
                            DataCell(Text("${elt.rate}%")),
                            DataCell(Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => BlocProvider.value(
                                        value: sl<DashboardBloc>(),
                                        child: TvaFormModal(
                                          tva: elt,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    sl<GlobalBloc>().add(
                                        GlobalDeleteTvaEvent(tvaId: elt.id));
                                  },
                                ),
                              ],
                            )),
                          ]))
                      .toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class TvaFormModal extends StatefulWidget {
  final TvaModel? tva; // Pass the brand object for editing, null for adding
  const TvaFormModal({super.key, this.tva});

  @override
  State<TvaFormModal> createState() => _TvaFormModalState();
}

class _TvaFormModalState extends State<TvaFormModal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.tva != null) {
      // Pre-fill the form for editing
      _nameController.text = widget.tva!.name;
      _rateController.text = widget.tva!.rate.toString();
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to avoid memory leaks
    _nameController.dispose();
    _rateController.dispose();
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
                widget.tva == null ? 'Add Tva' : 'Edit Tva',
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
                      controller: _rateController,
                      decoration: const InputDecoration(
                        labelText: 'Rate',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Rate percentage.';
                        }

                        // Check if the input is a valid number
                        final year = int.tryParse(value);
                        if (year == null) {
                          return 'Please enter a valid number.';
                        }

                        if (year < 0 || year > 100) {
                          return 'Please enter a rate between 0 and 100';
                        }

                        return null;
                      },
                      keyboardType:
                          TextInputType.number, // Ensure numeric input
                      autofocus: true,
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
                            DashboardUpsertTvaModelEvent(
                                tvaId: widget.tva?.id,
                                name: _nameController.text,
                                rate: double.parse(_rateController.text)));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(widget.tva != null ? 'Edit' : 'Save'),
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

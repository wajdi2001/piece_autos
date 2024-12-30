import 'package:flutter/material.dart';

class CarModelCrudUI extends StatelessWidget {
  const CarModelCrudUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Car Model Management',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Table View
              Expanded(
                child: CarModelTable(),
              ),
              // Form View
              SizedBox(
                width: 300,
                child: CarModelForm(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CarModelTable extends StatelessWidget {
  const CarModelTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Year of Construction')),
        DataColumn(label: Text('Brand ID')),
        DataColumn(label: Text('Actions')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('1')),
          DataCell(Text('Model A')),
          DataCell(Text('2022')),
          DataCell(Text('Brand A')),
          DataCell(Row(
            children: [
              IconButton(icon: Icon(Icons.edit), onPressed: () {}),
              IconButton(icon: Icon(Icons.delete), onPressed: () {}),
            ],
          )),
        ]),
      ],
    );
  }
}

class CarModelForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CarModelForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Name'),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(labelText: 'Year of Construction'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: InputDecoration(labelText: 'Brand ID'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save logic
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

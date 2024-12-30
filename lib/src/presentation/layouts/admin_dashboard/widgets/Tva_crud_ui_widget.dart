import 'package:flutter/material.dart';

class TVACrudUI extends StatelessWidget {
  const TVACrudUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TVA Management',
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
                child: TVATable(),
              ),
              // Form View
              Container(
                width: 300,
                child: TVAForm(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TVATable extends StatelessWidget {
  const TVATable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('ID')),
        DataColumn(label: Text('Name')),
        DataColumn(label: Text('Percentage')),
        DataColumn(label: Text('Actions')),
      ],
      rows: [
        DataRow(cells: [
          DataCell(Text('1')),
          DataCell(Text('Standard Rate')),
          DataCell(Text('20.0%')),
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

class TVAForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TVAForm({super.key});

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
            decoration: InputDecoration(labelText: 'Percentage'),
            keyboardType: TextInputType.number,
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

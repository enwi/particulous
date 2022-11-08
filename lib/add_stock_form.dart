import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/data/stock.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_dropdown.dart';

class AddStockForm extends StatefulWidget {
  final DBHandler dbHandler;
  final Part? initialPart;
  const AddStockForm({super.key, required this.dbHandler, this.initialPart});

  @override
  State<AddStockForm> createState() => _AddStockFormState();
}

class _AddStockFormState extends State<AddStockForm> {
  final _formKey = GlobalKey<FormState>();

  Part? _stockPart;
  int _stockAmount = 0;
  double? _stockPrice;
  String? _stockNote;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PartDropdown(
            dbHandler: widget.dbHandler,
            initialPart: widget.initialPart,
            labelText: 'Part',
            onSaved: (newValue) => _stockPart = newValue,
          ),
          const SizedBox(height: 16),
          SpinBox(
            decoration: const InputDecoration(label: Text('Amount')),
            min: 0.0,
            max: double.maxFinite,
            value: 0.0,
            onChanged: (newValue) => _stockAmount = newValue.toInt(),
          ),
          const SizedBox(height: 16),
          SpinBox(
            decoration: const InputDecoration(label: Text('Price (optional)')),
            min: 0.0,
            max: double.maxFinite,
            value: 0.0,
            decimals: 4,
            onChanged: (newValue) => _stockPrice = newValue,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Note (optional)')),
            onSaved: (newValue) => _stockNote = newValue,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              widget.dbHandler
                  .insertStock(Stock(
                id: -1,
                part: _stockPart!.identifier,
                amount: _stockAmount,
                price: _stockPrice,
                note: _stockNote,
                modified: DateTime.now(),
              ))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Successfully created new category with ID $value'),
                ));
                Navigator.pop(context);
              });
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

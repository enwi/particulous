import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/data/stock.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/location_dropdown.dart';
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
  Location? _stockLocation;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PartDropdown(
            options: widget.dbHandler.fetchParts(),
            initialOption: widget.initialPart,
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
          LocationDropdown(
            dbHandler: widget.dbHandler,
            labelText: 'Location (optional)',
            onSaved: ((newValue) => _stockLocation = newValue),
            validator: (value) {
              if (value == null) {
                return 'Stock must have a location';
              }
              return null;
            },
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
                location: _stockLocation!,
                modified: DateTime.now(),
              ))
                  .then((id) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Successfully created new stock with ID $id'),
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

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:particulous/data/stock.dart';

import 'data/part.dart';
import 'db/db_handler.dart';
import 'part_dropdown.dart';

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
          SpinBox(
            min: 0.0,
            max: double.maxFinite,
            value: 0.0,
            onChanged: (newValue) => _stockAmount = newValue.toInt(),
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

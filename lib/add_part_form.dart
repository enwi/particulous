import 'package:flutter/material.dart';
import 'package:particulous/data/category.dart';

import 'category_dropdown.dart';
import 'data/part.dart';
import 'db/db_handler.dart';

class AddPartForm extends StatefulWidget {
  final DBHandler dbHandler;
  const AddPartForm({super.key, required this.dbHandler});

  @override
  State<AddPartForm> createState() => _AddPartFormState();
}

class _AddPartFormState extends State<AddPartForm> {
  final _formKey = GlobalKey<FormState>();

  String? _partName;
  Category? _partCategory;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Part name')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Part must have a name';
              }
              if (value.length > 1024) {
                return 'Part can only have 1024 characters max';
              }
              return null;
            },
            onSaved: (newValue) => _partName = newValue,
          ),
          CategoryDropdown(
            dbHandler: widget.dbHandler,
            onSaved: (newValue) => _partCategory = newValue,
            validator: (value) {
              if (value == null) {
                return 'Part must have a category';
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
                  .insertPart(Part(
                      identifier: -1,
                      name: _partName!,
                      category: _partCategory!))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Successfully created new part with ID $value')));
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

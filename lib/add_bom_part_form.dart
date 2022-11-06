import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'data/part.dart';
import 'db/db_handler.dart';
import 'part_dropdown.dart';
import 'util/check_box_form_field.dart';

class AddBOMPartForm extends StatefulWidget {
  final DBHandler dbHandler;

  /// Part to add BOM item for
  final Part? initialParent;
  const AddBOMPartForm(
      {super.key, required this.dbHandler, this.initialParent});

  @override
  State<AddBOMPartForm> createState() => _AddBOMPartFormState();
}

class _AddBOMPartFormState extends State<AddBOMPartForm> {
  final _formKey = GlobalKey<FormState>();

  late Part? _bomParent = widget.initialParent;
  Part? _bomPart;
  int _bomAmount = 0;
  String? _bomReference;
  bool? _bomOptional = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          PartDropdown(
            dbHandler: widget.dbHandler,
            initialPart: widget.initialParent,
            labelText: 'Parent part',
            onSaved: (newValue) => _bomParent = newValue,
          ),
          PartDropdown(
            dbHandler: widget.dbHandler,
            labelText: 'Part',
            onSaved: (newValue) => _bomPart = newValue,
            validator: (value) {
              if (value?.identifier == _bomParent?.identifier) {
                return 'Part cannot be the same as the parent';
              }
              if (value?.identifier == _bomParent?.variant) {
                return 'Part cannot be the same as a variant of the parent';
              }
              return null;
            },
          ),
          SpinBox(
            min: 0.0,
            max: double.maxFinite,
            value: 0.0,
            onChanged: (newValue) => _bomAmount = newValue.toInt(),
          ),
          TextFormField(
            decoration:
                const InputDecoration(label: Text('Reference (optional)')),
            onSaved: (newValue) => _bomReference = newValue,
          ),
          CheckboxFormField(
            title: const Text('Optional'),
            initialValue: false,
            onSaved: (newValue) => _bomOptional = newValue,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              widget.dbHandler
                  // TODO distinguish between BomPart with data and one for insertion where only identifiers matter
                  .insertBomPart(BomPart(
                parent: _bomParent!.identifier,
                part: _bomPart!,
                amount: _bomAmount,
                optional: _bomOptional!,
                reference: _bomReference,
              ))
                  .then((value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Successfully added new BOM'),
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
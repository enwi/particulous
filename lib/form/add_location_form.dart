import 'package:flutter/material.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/location_dropdown.dart';

class AddLocationForm extends StatefulWidget {
  final DBHandler dbHandler;
  const AddLocationForm({super.key, required this.dbHandler});

  @override
  State<AddLocationForm> createState() => _AddLocationFormState();
}

class _AddLocationFormState extends State<AddLocationForm> {
  final _formKey = GlobalKey<FormState>();

  String? _locationName;
  String? _locationDescription;
  Location? _locationParent;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(label: Text('Location name')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Location must have a name';
              }
              return null;
            },
            onSaved: (newValue) => _locationName = newValue,
          ),
          TextFormField(
            decoration:
                const InputDecoration(label: Text('Description (optional)')),
            onSaved: (newValue) => _locationDescription = newValue,
          ),
          LocationDropdown(
            dbHandler: widget.dbHandler,
            labelText: 'Parent location (optional)',
            onSaved: (newValue) => _locationParent = newValue,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              widget.dbHandler
                  .insertLocation(Location(
                id: -1,
                name: _locationName!,
                description: _locationDescription,
                parent: _locationParent?.id,
              ))
                  .then((id) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Successfully created new Location with ID $id'),
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

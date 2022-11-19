import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:particulous/data/build_order.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_dropdown.dart';
import 'package:sprintf/sprintf.dart';

class AddBuildOrderForm extends StatefulWidget {
  final DBHandler dbHandler;
  final Part? initialPart;
  const AddBuildOrderForm({
    super.key,
    required this.dbHandler,
    this.initialPart,
  });

  @override
  State<AddBuildOrderForm> createState() => _AddBuildOrderFormState();
}

class _AddBuildOrderFormState extends State<AddBuildOrderForm> {
  final _formKey = GlobalKey<FormState>();

  String? _buildOrderReference;
  late int? _buildOrderPart = widget.initialPart?.identifier;
  String? _buildOrderDescription;
  int _buildOrderAmount = 1;
  int? _buildOrderDestination;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FutureBuilder<String>(
            future: widget.dbHandler
                .getLatestBuildOrder()
                .then((value) => sprintf('BO%04d', [1 + (value?.id ?? 0)])),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return TextFormField(
                  initialValue: snapshot.data!,
                  decoration: const InputDecoration(
                      label: Text('Build Order Reference')),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Build Order must have a reference';
                    }
                    return null;
                  },
                  onSaved: (newValue) => _buildOrderReference = newValue,
                );
              }
              return const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 16),
                child: LinearProgressIndicator(),
              );
            },
          ),
          TextFormField(
            decoration:
                const InputDecoration(label: Text('Build Order Description')),
            onSaved: (newValue) => _buildOrderDescription = newValue,
          ),
          PartDropdown(
            options: widget.dbHandler.fetchAssemblyParts(),
            initialOption: widget.initialPart,
            onSaved: (newValue) => _buildOrderPart = newValue?.identifier,
            validator: (value) {
              if (value == null) {
                return 'Build Order must have a part';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          SpinBox(
            decoration: const InputDecoration(label: Text('Amount')),
            min: 1.0,
            max: double.maxFinite,
            value: _buildOrderAmount.toDouble(),
            onChanged: (newValue) => _buildOrderAmount = newValue.toInt(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              widget.dbHandler
                  .insertBuildOrder(BuildOrder(
                id: -1,
                reference: _buildOrderReference!,
                part: _buildOrderPart!,
                description: _buildOrderDescription,
                amount: _buildOrderAmount,
                destination: _buildOrderDestination,
                created: DateTime.now(),
                // completed: ,
              ))
                  .then((id) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Successfully created new build order with ID $id')));
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

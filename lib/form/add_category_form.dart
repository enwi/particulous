import 'package:flutter/material.dart';
import 'package:particulous/category_dropdown.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/db/db_handler.dart';

class AddCategoryForm extends StatefulWidget {
  final DBHandler dbHandler;
  const AddCategoryForm({super.key, required this.dbHandler});

  @override
  State<AddCategoryForm> createState() => _AddCategoryFormState();
}

class _AddCategoryFormState extends State<AddCategoryForm> {
  final _formKey = GlobalKey<FormState>();

  String? _categoryName;
  String? _categoryDescription;
  Category? _categoryParent;
  String? _categoryKeywords;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
                // border: OutlineInputBorder(),
                // hintText: 'resistors',
                label: Text('Category name')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Category must have a name';
              }
              return null;
            },
            onSaved: (newValue) => _categoryName = newValue,
          ),
          TextFormField(
            decoration: const InputDecoration(label: Text('Description')),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Category must have a description';
              }
              return null;
            },
            onSaved: (newValue) => _categoryDescription = newValue,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'resistor 0805 SMD ...',
              label: Text('Keywords'),
            ),
            onSaved: (newValue) => _categoryKeywords = newValue,
          ),
          CategoryDropdown(
            dbHandler: widget.dbHandler,
            labelText: 'Parent category (optional)',
            onSaved: (newValue) => _categoryParent = newValue,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              widget.dbHandler
                  .insertCategory(Category(
                      identifier: -1,
                      name: _categoryName!,
                      description: _categoryDescription!,
                      keywords: _categoryKeywords,
                      parent: _categoryParent?.identifier))
                  .then((id) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text('Successfully created new category with ID $id'),
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

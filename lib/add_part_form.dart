import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:particulous/category_dropdown.dart';
import 'package:particulous/data/settings.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_dropdown.dart';
import 'package:particulous/util/check_box_form_field.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class AddPartForm extends StatefulWidget {
  final DBHandler dbHandler;
  final String? name;
  final String? description;
  final List<PlatformFile> images;
  const AddPartForm({
    super.key,
    required this.dbHandler,
    this.name,
    this.description,
    this.images = const [],
  });

  @override
  State<AddPartForm> createState() => _AddPartFormState();
}

class _AddPartFormState extends State<AddPartForm> {
  final _formKey = GlobalKey<FormState>();

  String? _partIpn;
  String? _partName;
  String? _partDescription;
  Category? _partCategory;
  PlatformFile? _partImage;
  Part? _partVariant;
  bool? _partTemplate;
  bool? _partAssembly;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.name,
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
          TextFormField(
            decoration: const InputDecoration(
                label: Text('Internal Product Number (IPN)')),
            onSaved: (newValue) => _partIpn = newValue,
          ),
          TextFormField(
            initialValue: widget.description,
            decoration: const InputDecoration(label: Text('Description')),
            onSaved: (newValue) => _partDescription = newValue,
          ),
          CategoryDropdown(
            dbHandler: widget.dbHandler,
            labelText: 'Category',
            onSaved: (newValue) => _partCategory = newValue,
            validator: (value) {
              if (value == null) {
                return 'Part must have a category';
              }
              return null;
            },
          ),
          FormBuilderFilePicker(
            initialValue: widget.images,
            name: 'image',
            allowMultiple: false,
            maxFiles: 1,
            onSaved: (newValue) => _partImage =
                newValue?.isNotEmpty ?? false ? newValue?.first : null,
            typeSelectors: [
              TypeSelector(
                type: FileType.image,
                selector: Row(
                  children: const [
                    Icon(Icons.add_circle),
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Add image"),
                    ),
                  ],
                ),
              )
            ],
          ),
          PartDropdown(
            options: widget.dbHandler.fetchTemplateParts(),
            labelText: 'Variant of',
            onSaved: (newValue) => _partVariant = newValue,
          ),
          CheckboxFormField(
            title: const Text('Template part'),
            initialValue: false,
            onSaved: (newValue) => _partTemplate = newValue,
          ),
          CheckboxFormField(
            title: const Text('Can this part be assembled from other parts?'),
            initialValue: false,
            onSaved: (newValue) => _partAssembly = newValue,
          ),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              final internalImage = _partImage == null
                  ? null
                  : '${_partName.hashCode}.${(_partImage!.extension ?? 'png')}';
              widget.dbHandler
                  .insertPart(Part(
                identifier: -1,
                ipn: _partIpn,
                name: _partName!,
                description: _partDescription,
                category: _partCategory!,
                image: internalImage,
                variant: _partVariant?.identifier,
                template: _partTemplate!,
                assembly: _partAssembly!,
                // sku: ,
                // mpn: ,
              ))
                  .then((value) {
                if (internalImage != null) {
                  final settings =
                      Provider.of<Settings>(context, listen: false);
                  File(join(settings.imageDir, internalImage)).writeAsBytes(
                      _partImage!.bytes ??
                          File(_partImage!.path!).readAsBytesSync());
                }
                return value;
              }).then((id) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text('Successfully created new part with ID $id')));
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

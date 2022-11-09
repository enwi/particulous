import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/util/dropdown_widget.dart';

class PartDropdown extends DropdownWidget<Part> {
  PartDropdown({
    super.key,
    required Future<List<Part>> options,
    final String? labelText,
    final FormFieldSetter<Part>? onSaved,
    final FormFieldValidator<Part>? validator,
    Part? initialOption,
  }) : super(
          options: options,
          initialOption: initialOption,
          compareFn: (a, b) => a.identifier == b.identifier,
          itemAsString: (item) => '${item.name} (${item.identifier})',
          labelText: labelText,
          onSaved: onSaved,
          validator: validator,
        );
}

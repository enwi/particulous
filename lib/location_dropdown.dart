import 'package:flutter/material.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/util/dropdown_widget.dart';

class LocationDropdown extends DropdownWidget<Location> {
  final DBHandler dbHandler;

  LocationDropdown({
    super.key,
    required this.dbHandler,
    String? labelText,
    FormFieldSetter<Location>? onSaved,
    FormFieldValidator<Location>? validator,
  }) : super(
          options: dbHandler.fetchLocations(),
          compareFn: (a, b) => a.id == b.id,
          itemAsString: (item) => '${item.name} (${item.id})',
          labelText: labelText,
          onSaved: onSaved,
          validator: validator,
        );
}

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';

class PartDropdown extends StatefulWidget {
  final DBHandler? dbHandler;
  final Future<List<Part>> Function()? fetchParts;
  final String? labelText;
  final FormFieldSetter<Part>? onSaved;
  final FormFieldValidator<Part>? validator;
  final Part? initialPart;

  const PartDropdown({
    super.key,
    this.dbHandler,
    this.fetchParts,
    this.labelText,
    this.onSaved,
    this.validator,
    this.initialPart,
  }) : assert(dbHandler != null || fetchParts != null,
            'dbHandler or fetchParts required');

  @override
  State<PartDropdown> createState() => _PartDropdownState();
}

class _PartDropdownState extends State<PartDropdown> {
  final _dropdownKey = GlobalKey<DropdownSearchState<Part>>();

  late final Future<List<Part>> _parts;

  @override
  void initState() {
    _parts = widget.dbHandler?.fetchParts() ?? widget.fetchParts!();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Part>(
      key: _dropdownKey,
      selectedItem: widget.initialPart,
      popupProps: PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              label: Text('Search parts'),
            ),
          ),
          containerBuilder: (ctx, popupWidget) {
            return Column(
              children: [
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        _dropdownKey.currentState?.closeDropDownSearch();
                      },
                      child: const Text('Cancel'),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _dropdownKey.currentState?.popupDeselectAllItems();
                        _dropdownKey.currentState?.clear();
                      },
                      child: const Text('None'),
                    ),
                  ],
                ),
                Expanded(child: popupWidget),
              ],
            );
          }),
      compareFn: (item1, item2) => item1.identifier == item2.identifier,
      asyncItems: (text) => _parts,
      itemAsString: (item) => '${item.name} (${item.identifier})',
      onSaved: widget.onSaved,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: widget.labelText,
        ),
      ),
      validator: widget.validator,
    );
  }
}
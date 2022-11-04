import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'data/category.dart';
import 'db/db_handler.dart';

class CategoryDropdown extends StatefulWidget {
  final DBHandler dbHandler;
  final String? labelText;
  final FormFieldSetter<Category>? onSaved;
  final FormFieldValidator<Category>? validator;
  const CategoryDropdown({
    super.key,
    required this.dbHandler,
    this.labelText,
    this.onSaved,
    this.validator,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final _dropdownKey = GlobalKey<DropdownSearchState<Category>>();

  late final Future<List<Category>> _categories;

  @override
  void initState() {
    _categories = widget.dbHandler.fetchCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<Category>(
      key: _dropdownKey,
      popupProps: PopupProps.menu(
          showSelectedItems: true,
          showSearchBox: true,
          searchFieldProps: const TextFieldProps(
            decoration: InputDecoration(
              label: Text('Search categories'),
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
      asyncItems: (text) => _categories,
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

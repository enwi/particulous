import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownWidget<T> extends StatelessWidget {
  /// All [options] that can be choosed from
  final Future<List<T>> options;

  /// Optional initially selected option
  final T? initialOption;

  /// Optional displayed label
  final String? labelText;

  /// Callback when form gets saved
  final FormFieldSetter<T>? onSaved;

  /// Form validator
  final FormFieldValidator<T>? validator;

  /// Comparison function to distinguish options
  final bool Function(T, T)? compareFn;

  /// Function for generating displayed option
  final String Function(T)? itemAsString;

  final _dropdownKey = GlobalKey<DropdownSearchState<T>>();
  DropdownWidget({
    super.key,
    required this.options,
    this.initialOption,
    this.labelText,
    this.onSaved,
    this.validator,
    this.compareFn,
    this.itemAsString,
  });

  @override
  Widget build(BuildContext context) => DropdownSearch<T>(
        key: _dropdownKey,
        selectedItem: initialOption,
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
          },
        ),
        compareFn: compareFn,
        asyncItems: (text) => options,
        itemAsString: itemAsString,
        onSaved: onSaved,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: labelText,
          ),
        ),
        validator: validator,
      );
}

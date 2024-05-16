import 'package:particulous/data/part.dart';
import 'package:particulous/util/dropdown_widget.dart';

class PartDropdown extends DropdownWidget<Part> {
  PartDropdown({
    super.key,
    required super.options,
    super.labelText,
    super.onSaved,
    super.validator,
    super.initialOption,
  }) : super(
          compareFn: (a, b) => a.identifier == b.identifier,
          itemAsString: (item) => '${item.name} (${item.identifier})',
        );
}

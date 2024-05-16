import 'package:particulous/data/category.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/util/dropdown_widget.dart';

class CategoryDropdown extends DropdownWidget<Category> {
  final DBHandler dbHandler;
  CategoryDropdown({
    super.key,
    required this.dbHandler,
    super.labelText,
    super.onSaved,
    super.validator,
  }) : super(
          options: dbHandler.fetchCategories(),
          compareFn: (a, b) => a.identifier == b.identifier,
          itemAsString: (item) => '${item.name} (${item.identifier})',
        );
}

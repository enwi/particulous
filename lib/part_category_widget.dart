import 'package:flutter/material.dart';
import 'package:particulous/db/db_handler.dart';

import 'category_screen.dart';
import 'data/category.dart';
import 'data/part.dart';

class PartCategoryWidget extends StatelessWidget {
  final DBHandler dbh;
  final Part part;
  final bool clickableCategories;

  const PartCategoryWidget({
    super.key,
    required this.dbh,
    required this.part,
    this.clickableCategories = false,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: dbh.getParentCategories(part.category.identifier),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children:
                snapshot.data!.map((e) => _buildChip(context, e)).toList(),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }

  Widget _buildChip(final BuildContext context, final Category category) {
    return ActionChip(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      labelPadding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.3),
        child: Text(
          '${category.identifier}',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      label: Text(
        category.name,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: colorFor(category.name),
      elevation: 2.0,
      onPressed: clickableCategories
          ? () => Navigator.pushNamed(
                context,
                CategoryScreen.route,
                arguments: CategoryScreenArgs(
                  categoryId: category.identifier,
                  category: category,
                ),
              )
          : () => {},
    );
  }

  Color colorFor(final String text) {
    var hash = 0;
    for (var i = 0; i < text.length; ++i) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
      // hash = hash & hash;
    }
    return HSVColor.fromAHSV(1.0, hash % 360, 0.8, 0.8).toColor();
  }
}

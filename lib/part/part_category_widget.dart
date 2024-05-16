import 'package:flutter/material.dart';
import 'package:particulous/category_screen.dart';
import 'package:particulous/data/category.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';

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
    return FutureBuilder(
      future: dbh.getParentCategories(part.category.identifier),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: snapshot.data!
                .map((e) => buildChip(context, e, clickableCategories))
                .toList(),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }

  static Widget buildChip(
    final BuildContext context,
    final Category category,
    final bool clickable,
  ) {
    return ActionChip(
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      labelPadding: const EdgeInsets.all(2.0),
      // avatar: CircleAvatar(
      //   backgroundColor: const Color.fromRGBO(255, 255, 255, 0.3),
      //   child: Text(
      //     '${category.identifier}',
      //     style: const TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      label: Text(
        category.name,
        // style: const TextStyle(
        //   color: Colors.white,
        // ),
      ),
      // backgroundColor: ColorUtil.colorFor(category.name),
      // elevation: 2.0,
      onPressed: clickable
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
}

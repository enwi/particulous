import 'dart:io';

import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'category_screen.dart';
import 'data/category.dart';
import 'main.dart';

class PartWidget extends StatefulWidget {
  final DBHandler dbh;
  final Part part;
  final bool clickableCategories;

  const PartWidget(
      {super.key,
      required this.dbh,
      required this.part,
      this.clickableCategories = false});

  @override
  State<PartWidget> createState() => _PartWidgetState();
}

class _PartWidgetState extends State<PartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 275),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 2.0).animate(CurvedAnimation(
        parent: _controller, curve: Curves.ease, reverseCurve: Curves.easeIn));
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageDir = Provider.of<ApplicationDirectories>(context).imageDir.path;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: MouseRegion(
              onEnter: (value) {
                setState(() {
                  _controller.forward();
                });
              },
              onExit: (value) {
                setState(() {
                  _controller.reverse();
                });
              },
              child: SizedBox(
                width: 150.0 * _animation.value,
                height: 150.0 * _animation.value,
                child: widget.part.image == null
                    ? null
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          File(join(imageDir, widget.part.image!)),
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    widget.part.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    widget.part.description ?? 'No description',
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                  child: FutureBuilder<List<Category>>(
                    future: widget.dbh
                        .getParentCategories(widget.part.category.identifier),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: snapshot.data!
                              .map((e) => _buildChip(context, e))
                              .toList(),
                        );
                      }
                      return const LinearProgressIndicator();
                    },
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(5, 40, 0, 0),
                child: Text(
                  '\$ 24.00',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // ListTile(
    //   leading: part.image == null
    //       ? null
    //       : SizedBox(
    //           width: 100,
    //           height: 200,
    //           child: Image.file(
    //             File(part.image!),
    //           ),
    //         ),
    //   title: Text(part.name),
    //   subtitle: FutureBuilder<List<Category>>(
    //     future: dbh.getParentCategories(part.category.identifier)
    //     // .then((value) => value.fold(
    //     //     '',
    //     //     (previousValue, element) =>
    //     //         '$previousValue -> $element'))
    //     ,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         // return Text(snapshot.data!);
    //         return Wrap(
    //           spacing: 6.0,
    //           runSpacing: 6.0,
    //           children:
    //               snapshot.data!.map((e) => _buildChip(context, e)).toList(),
    //         );
    //       }
    //       return const LinearProgressIndicator();
    //     },
    //   ),
    // );
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
      // shadowColor: Colors.grey[60],
      onPressed: widget.clickableCategories
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
    return HSVColor.fromAHSV(1.0, hash % 360, 0.8, 0.95).toColor();
  }
}

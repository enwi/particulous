import 'dart:io';

import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part_category_widget.dart';
import 'package:particulous/part_detail_screen.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class PartWidget extends StatefulWidget {
  final DBHandler dbh;
  final Part part;
  final bool clickableCategories;

  const PartWidget({
    super.key,
    required this.dbh,
    required this.part,
    this.clickableCategories = false,
  });

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
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PartDetailScreen(dbh: widget.dbh, part: widget.part),
        ),
      ),
      child: Card(
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
                  width: size.width - 20 - 150.0 * _animation.value,
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
                  width: size.width - 20 - 150.0 * _animation.value,
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
                  width: size.width - 20 - 150.0 * _animation.value,
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: PartCategoryWidget(
                        dbh: widget.dbh,
                        part: widget.part,
                        clickableCategories: widget.clickableCategories,
                      )),
                ),
              ],
            ),
            // Column(
            //   children: const [
            //     Padding(
            //       padding: EdgeInsets.fromLTRB(5, 40, 0, 0),
            //       child: Text(
            //         '\$ 24.00',
            //         style: TextStyle(
            //           fontSize: 14,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

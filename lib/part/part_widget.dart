import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_category_widget.dart';
import 'package:particulous/part/part_detail_screen.dart';
import 'package:particulous/part/part_image_widget.dart';

class PartWidget extends StatefulWidget {
  final DBHandler dbh;
  final Part part;
  final bool clickableCategories;

  /// Callback for tapping on the part,
  /// if not specified this will push a new PartDetailScreen using Navigator.push
  final GestureTapCallback? onTap;

  const PartWidget({
    super.key,
    required this.dbh,
    required this.part,
    this.clickableCategories = false,
    this.onTap,
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.onTap ??
          () => Navigator.push(
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
            MouseRegion(
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
                        borderRadius: BorderRadius.circular(2.0),
                        child: PartImageWidget(image: widget.part.image!),
                      ),
              ),
            ),
            Container(
              width: size.width - 20 - 150.0 * _animation.value,
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    widget.part.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  StreamBuilder(
                    stream: widget.dbh
                        .watchStockCountOfPart(widget.part.identifier),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data} in Stock');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.part.description ?? 'No description',
                    style: const TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  PartCategoryWidget(
                    dbh: widget.dbh,
                    part: widget.part,
                    clickableCategories: widget.clickableCategories,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

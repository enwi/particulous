import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particulous/build_order_table.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';

class PartBuildOrderTable extends StatefulWidget {
  final DBHandler dbh;
  final Part part;
  const PartBuildOrderTable({
    super.key,
    required this.dbh,
    required this.part,
  });

  @override
  State<PartBuildOrderTable> createState() => _PartBuildOrderTableState();
}

class _PartBuildOrderTableState extends State<PartBuildOrderTable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.dbh.watchBuildOrdersOfPart(widget.part.identifier),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final orders = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              child: BuildOrderTable(
                // TODO find better method than this key to force update
                key: Key("${Random().nextDouble()}"),
                dbh: widget.dbh,
                orders: orders,
              ),
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particulous/bom_table.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';

class PartBOMTable extends StatefulWidget {
  final DBHandler dbh;
  final Part part;
  const PartBOMTable({
    super.key,
    required this.dbh,
    required this.part,
  });

  @override
  State<PartBOMTable> createState() => _PartBOMTableState();
}

class _PartBOMTableState extends State<PartBOMTable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.dbh.watchBOMOfPart(widget.part.identifier),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final parts = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: BomTable(
              // TODO find better method than this key to force update
              key: Key("${Random().nextDouble()}"),
              dbh: widget.dbh,
              parts: parts,
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}

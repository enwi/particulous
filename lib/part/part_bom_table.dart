import 'dart:math';

import 'package:flutter/material.dart';
import 'package:particulous/data/application_directories.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:provider/provider.dart';

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

class BomTable extends StatefulWidget {
  final DBHandler dbh;
  final List<BomPart> parts;
  const BomTable({
    super.key,
    required this.dbh,
    required this.parts,
  });

  @override
  State<BomTable> createState() => _BomTableState();
}

class _BomTableState extends State<BomTable> {
  int _sortColumnIndex = 1;
  bool _sortAsc = false;
  late List<BomPart> _parts = widget.parts;

  @override
  Widget build(BuildContext context) {
    final imageDir = Provider.of<ApplicationDirectories>(context).imageDir.path;
    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAsc,
      columnSpacing: 16,
      horizontalMargin: 16,
      columns: [
        const DataColumn(label: Text('Part')),
        DataColumn(
          label: const Text('Amount'),
          numeric: true,
          onSort: (columnIndex, ascending) {
            setState(() {
              if (columnIndex == _sortColumnIndex) {
                _sortAsc = ascending;
              } else {
                _sortColumnIndex = columnIndex;
                _sortAsc = false;
              }
              _parts.sort((a, b) => a.amount.compareTo(b.amount));
              if (!ascending) {
                _parts = _parts.reversed.toList();
              }
            });
          },
        ),
        const DataColumn(label: Text('Optional')),
      ],
      rows: _parts.map((part) {
        return DataRow(cells: [
          DataCell(
            Wrap(
              direction: Axis.horizontal,
              children: [
                if (part.part.image != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      height: kMinInteractiveDimension,
                      width: kMinInteractiveDimension,
                      part.part.getImageFile(imageDir)!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ] else ...[
                  const SizedBox(
                    width: kMinInteractiveDimension,
                    height: kMinInteractiveDimension,
                  )
                ],
                const SizedBox(width: 8),
                Text(part.part.name),
              ],
            ),
          ),
          DataCell(
            Text('${part.amount}'),
          ),
          DataCell(Text('${part.optional}')),
        ]);
      }).toList(),
    );
  }
}

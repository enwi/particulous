import 'package:flutter/material.dart';
import 'package:particulous/data/bom_part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_image_widget.dart';

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
  final Map<int, double> _partHasCanBuild = {};

  @override
  void initState() {
    _parts.sort((a, b) => a.amount.compareTo(b.amount));
    _parts = _parts.reversed.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              if (columnIndex != _sortColumnIndex) {
                _sortColumnIndex = columnIndex;
              } else {
                _sortAsc = !_sortAsc;
              }
              _parts.sort((a, b) => a.amount.compareTo(b.amount));
              if (!_sortAsc) {
                _parts = _parts.reversed.toList();
              }
            });
          },
        ),
        const DataColumn(label: Text('Reference')),
        const DataColumn(label: Text('Optional')),
        const DataColumn(label: Text('Variants')),
        DataColumn(
          label: const Text('Can build'),
          numeric: true,
          onSort: (columnIndex, ascending) {
            setState(() {
              if (columnIndex != _sortColumnIndex) {
                _sortColumnIndex = columnIndex;
              } else {
                _sortAsc = !_sortAsc;
              }
              _parts.sort((a, b) => (_partHasCanBuild[a.part.identifier] ?? 0)
                  .compareTo((_partHasCanBuild[b.part.identifier]) ?? 0));
              if (!_sortAsc) {
                _parts = _parts.reversed.toList();
              }
            });
          },
        ),
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
                    child: PartImageWidget(
                      image: part.part.image!,
                      height: kMinInteractiveDimension,
                      width: kMinInteractiveDimension,
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
          DataCell(Text('${part.amount}')),
          DataCell(Text(part.reference ?? '-')),
          DataCell(yesNoChip(part.optional)),
          DataCell(yesNoChip(part.variants)),
          DataCell(StreamBuilder(
            stream: widget.dbh.watchStockCountOfPart(part.part.identifier),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final canBuild = snapshot.data! / part.amount;
                _partHasCanBuild[part.part.identifier] = canBuild;
                return Chip(
                  label: Text('${canBuild.floor()}'),
                  backgroundColor: canBuild <= 5
                      ? canBuild <= 1
                          ? Colors.red
                          : Colors.orange
                      : Colors.green,
                );
              }
              return const CircularProgressIndicator();
            },
          )),
        ]);
      }).toList(),
    );
  }

  Chip yesNoChip(final bool yes) {
    return yes
        ? const Chip(
            label: Text('yes'),
            backgroundColor: Colors.green,
          )
        : const Chip(
            label: Text('no'),
            backgroundColor: Colors.orange,
          );
  }
}

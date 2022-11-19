import 'package:flutter/material.dart';
import 'package:particulous/data/build_order.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_image_widget.dart';

import 'data/part.dart';

class BuildOrderTable extends StatefulWidget {
  final DBHandler dbh;
  final List<BuildOrder> orders;
  const BuildOrderTable({
    super.key,
    required this.dbh,
    required this.orders,
  });

  @override
  State<BuildOrderTable> createState() => _BuildOrderTableState();
}

class _BuildOrderTableState extends State<BuildOrderTable> {
  int _sortColumnIndex = 1;
  bool _sortAsc = false;
  late List<BuildOrder> _orders = widget.orders;

  @override
  void initState() {
    _orders.sort((a, b) => a.amount.compareTo(b.amount));
    _orders = _orders.reversed.toList();
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
        const DataColumn(label: Text('Build Order')),
        const DataColumn(label: Text('Description')),
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
              _orders.sort((a, b) => a.amount.compareTo(b.amount));
              if (!_sortAsc) {
                _orders = _orders.reversed.toList();
              }
            });
          },
        ),
        const DataColumn(label: Text('Created')),
        const DataColumn(label: Text('Completed')),
      ],
      rows: _orders.map((order) {
        return DataRow(cells: [
          DataCell(Text(order.reference)),
          DataCell(Text(order.description ?? '-')),
          DataCell(
            FutureBuilder<Part?>(
              future: widget.dbh.fetchPart(order.part),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final part = snapshot.data!;
                  return Wrap(
                    direction: Axis.horizontal,
                    children: [
                      if (part.image != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: PartImageWidget(
                            image: part.image!,
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
                      Text(part.name),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
          DataCell(Text('${order.amount}')),
          DataCell(Text(order.created.toLocal().toString())),
          DataCell(Text(order.completed?.toLocal().toString() ?? '-')),
        ]);
      }).toList(),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:particulous/data/alter_stock.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/data/stock.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/util/string_util.dart';

class PartStockTable extends StatefulWidget {
  final DBHandler dbh;
  final Part part;
  const PartStockTable({
    super.key,
    required this.dbh,
    required this.part,
  });

  @override
  State<PartStockTable> createState() => _PartStockTableState();
}

class _PartStockTableState extends State<PartStockTable> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.dbh.watchStockOfPart(widget.part.identifier),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stocks = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: StockTable(
              // TODO find better method than this key to force update
              key: Key("${Random().nextDouble()}"),
              dbh: widget.dbh,
              stocks: stocks,
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}

class StockTable extends StatefulWidget {
  final DBHandler dbh;
  final List<Stock> stocks;
  const StockTable({
    super.key,
    required this.dbh,
    required this.stocks,
  });

  @override
  State<StockTable> createState() => _StockTableState();
}

class _StockTableState extends State<StockTable> {
  int _sortColumnIndex = 1;
  bool _sortAsc = false;
  late List<Stock> _stocks = widget.stocks;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAsc,
      columnSpacing: 16,
      horizontalMargin: 16,
      columns: [
        const DataColumn(
          label: Center(
            child: Text(
              'Actions',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataColumn(
          label: const Text('Stock'),
          numeric: true,
          onSort: (columnIndex, ascending) {
            setState(() {
              if (columnIndex == _sortColumnIndex) {
                _sortAsc = ascending;
              } else {
                _sortColumnIndex = columnIndex;
                _sortAsc = false;
              }
              _stocks.sort((a, b) => a.amount.compareTo(b.amount));
              if (!ascending) {
                _stocks = _stocks.reversed.toList();
              }
            });
          },
        ),
        const DataColumn(label: Text('Last updated')),
      ],
      rows: _stocks.map((stock) {
        final date = stock.modified.toLocal();
        return DataRow(cells: [
          DataCell(ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0),
                splashRadius: 24,
                icon: const Icon(Icons.add),
                onPressed: () {
                  final notesFieldController = TextEditingController();
                  var amount = 1;
                  showDialog<AlterStock>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Add stock'),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpinBox(
                              min: min(1, stock.amount).toDouble(),
                              max: double.maxFinite,
                              value: amount.toDouble(),
                              onChanged: (value) => amount = value.toInt(),
                            ),
                            TextField(
                              onChanged: (value) {},
                              controller: notesFieldController,
                              decoration:
                                  const InputDecoration(labelText: "Notes"),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Abort'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(
                              context,
                              AlterStock(
                                stock: stock.id,
                                amount: amount,
                                notes: notesFieldController.text,
                              )),
                        ),
                      ],
                    ),
                  )
                      .then(widget.dbh.alterStock)
                      .onError<Exception>((error, stackTrace) => 0);
                },
              ),
              IconButton(
                padding: const EdgeInsets.all(0),
                splashRadius: 24,
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final notesFieldController = TextEditingController();
                  var amount = 1;
                  showDialog<AlterStock>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Remove stock'),
                      content: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpinBox(
                              min: min(1, stock.amount).toDouble(),
                              max: stock.amount.toDouble(),
                              value: amount.toDouble(),
                              onChanged: (value) => amount = value.toInt(),
                            ),
                            TextField(
                              onChanged: (value) {},
                              controller: notesFieldController,
                              decoration:
                                  const InputDecoration(hintText: "Notes"),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Abort'),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () => Navigator.pop(
                              context,
                              AlterStock(
                                stock: stock.id,
                                amount: -amount,
                                notes: notesFieldController.text,
                              )),
                        ),
                      ],
                    ),
                  )
                      .then(widget.dbh.alterStock)
                      .onError<Exception>((error, stackTrace) => 0);
                },
              ),
            ],
          )),
          DataCell(
            Text('${stock.amount}'),
          ),
          DataCell(
            Text(StringUtil.formatDate(date)),
          ),
        ]);
      }).toList(),
    );
  }
}

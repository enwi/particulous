import 'package:flutter/material.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:particulous/data/bom_part.dart';
import 'package:particulous/data/build_order.dart';
import 'package:particulous/db/db_handler.dart';

import 'data/stock.dart';

class BuildOrderScreen extends StatefulWidget {
  final DBHandler dbh;
  final BuildOrder buildOrder;

  const BuildOrderScreen({
    super.key,
    required this.dbh,
    required this.buildOrder,
  });

  @override
  State<BuildOrderScreen> createState() => _BuildOrderScreenState();
}

class _BuildOrderScreenState extends State<BuildOrderScreen> {
  late final Stream<List<StockAllocation>> _allocations =
      widget.dbh.watchStockAllocationsOfBuildOrder(widget.buildOrder.id);

  late final Stream<List<BomPart>> _bom =
      widget.dbh.watchBOMOfPart(widget.buildOrder.part);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Order ${widget.buildOrder.reference}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: ${widget.buildOrder.amount}'),
          Text('Completed: ${widget.buildOrder.completed}'),
          Text('Created: ${widget.buildOrder.created}'),
          Text('Description: ${widget.buildOrder.description}'),
          Text('Destination: ${widget.buildOrder.destination}'),
          Text('ID: ${widget.buildOrder.id}'),
          Text('Part: ${widget.buildOrder.part}'),
          StreamBuilder2(
            streams: StreamTuple2(_bom, _allocations),
            builder: (context, snapshots) {
              if (snapshots.snapshot1.hasData && snapshots.snapshot2.hasData) {
                final bom = snapshots.snapshot1.data!;
                final allocations = snapshots.snapshot2.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Allocated: ${allocations.length}/${bom.length} parts (${bom.fold(0, (previousValue, element) => previousValue + element.amount)} individual items)'),
                    ...allocations
                        .map(
                            (e) => Text('Stock ${e.stock}, amount ${e.amount}'))
                        ,
                    const Text('BOM'),
                    ...bom
                        .map((e) => Row(
                              children: [
                                Text('${e.amount}x ${e.part.name}'),
                                FutureBuilder(
                                  future: widget.dbh.fetchTemplateStockOfPart(
                                      e.part.identifier),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                          'Assignable: ${snapshot.data!.fold('', (previousValue, element) => '$previousValue, ${element.part} (${element.amount})')}');
                                    }
                                    return const CircularProgressIndicator();
                                  },
                                ),
                              ],
                            ))
                        ,
                  ],
                );
              }
              return const LinearProgressIndicator();
            },
          )
        ],
      ),
    );
  }
}

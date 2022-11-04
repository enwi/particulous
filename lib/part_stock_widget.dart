import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';

import 'stock_widget.dart';

class PartStockWidget extends StatelessWidget {
  final DBHandler dbh;
  final Part part;
  const PartStockWidget({
    super.key,
    required this.dbh,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: dbh.watchStockOfPart(part.identifier),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stocks = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children:
                  stocks.map((e) => StockWidget(dbh: dbh, stock: e)).toList(),
            ),
          );
        }
        return const LinearProgressIndicator();
      },
    );
  }
}

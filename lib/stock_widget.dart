import 'package:flutter/material.dart';
import 'package:particulous/data/stock.dart';
import 'package:particulous/db/db_handler.dart';

class StockWidget extends StatelessWidget {
  final DBHandler dbh;
  final Stock stock;
  const StockWidget({super.key, required this.dbh, required this.stock});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {}
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         PartDetailScreen(dbh: widget.dbh, part: widget.part),
      //   ),
      // )
      ,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('${stock.amount}'),
              subtitle: Text('${stock.id}'),
            )
          ],
        ),
      ),
    );
  }
}

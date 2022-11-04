import 'dart:io';

import 'package:flutter/material.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part_stock_table.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'part_category_widget.dart';

const imageSize = 200.0;

class PartDetailScreen extends StatelessWidget {
  final DBHandler dbh;
  final Part part;
  const PartDetailScreen({
    super.key,
    required this.dbh,
    required this.part,
  });

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final imageDir = Provider.of<ApplicationDirectories>(context).imageDir.path;
    return Scaffold(
      appBar: AppBar(
        title: Text(part.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SizedBox(
                // width: imageSize * _animation.value,
                // height: imageSize * _animation.value,
                width: imageSize,
                height: imageSize,
                child: part.image == null
                    ? null
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.file(
                          File(join(imageDir, part.image!)),
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  part.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  part.description ?? 'No description',
                  style: const TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                child: PartCategoryWidget(dbh: dbh, part: part),
              ),
              const Divider(),
              StreamBuilder(
                stream: dbh.watchStockCountOfPart(part.identifier),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Stock - ${snapshot.data!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  return const LinearProgressIndicator();
                },
              ),
              // PartStockWidget(dbh: dbh, part: part),
              PartStockTable(dbh: dbh, part: part),
            ],
          ),
        ],
      ),
    );
  }
}

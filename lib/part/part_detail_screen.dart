import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:particulous/data/application_directories.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_bom_table.dart';
import 'package:particulous/part/part_category_widget.dart';
import 'package:particulous/part/part_stock_table.dart';
import 'package:particulous/util/add_utils.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

const imageSize = 200.0;

class PartDetailScreen extends StatefulWidget {
  final DBHandler dbh;
  final Part part;

  const PartDetailScreen({
    super.key,
    required this.dbh,
    required this.part,
  });

  @override
  State<PartDetailScreen> createState() => _PartDetailScreenState();
}

class _PartDetailScreenState extends State<PartDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isImageHover = false;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final imageDir = Provider.of<ApplicationDirectories>(context).imageDir.path;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.part.name),
      ),
      body: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: InkWell(
                    onHover: (value) => setState(() => _isImageHover = value),
                    onTap: () => FilePicker.platform
                        .pickFiles(
                      allowMultiple: false,
                      type: FileType.image,
                      lockParentWindow: true,
                    )
                        .then(
                      (result) {
                        if (result == null || result.count != 1) {
                          log('No files have been picked');
                          return;
                        }

                        final image = result.files.first;
                        final imageFileName =
                            '${widget.part.image?.split('.').first ?? '${widget.part.name.hashCode}'}.${image.extension ?? 'png'}';
                        final dirs = Provider.of<ApplicationDirectories>(
                            context,
                            listen: false);
                        File(join(dirs.imageDir.path, imageFileName))
                            .writeAsBytes(image.bytes ??
                                File(image.path!).readAsBytesSync());
                        if (widget.part.image == null) {
                          widget.dbh.updateImageOfPart(
                              imageFileName, widget.part.identifier);
                        }
                      },
                    ),
                    child: SizedBox(
                      width: imageSize,
                      height: imageSize,
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: widget.part.image == null
                                  ? Container(
                                      color: Colors.grey.shade400,
                                      child:
                                          const Center(child: Text('No Image')),
                                    )
                                  : Image.file(
                                      File(join(imageDir, widget.part.image!)),
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                          if (_isImageHover) ...[
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: const Chip(label: Text('Edit')),
                            )
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.part.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      widget.part.description ?? 'No description',
                      style: const TextStyle(
                        // fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child:
                        PartCategoryWidget(dbh: widget.dbh, part: widget.part),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: StreamBuilder(
                      stream: widget.dbh
                          .watchStockCountOfPart(widget.part.identifier),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Row(
                            children: [
                              Text(
                                'Stock - ${snapshot.data!}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Tooltip(
                                message: 'Add new stock',
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  splashRadius: 20,
                                  onPressed: () => AddUtils.addStock(
                                    context: context,
                                    dbh: widget.dbh,
                                    part: widget.part,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const LinearProgressIndicator();
                      },
                    ),
                  ),
                  PartStockTable(dbh: widget.dbh, part: widget.part),
                  if (widget.part.assembly) ...[
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          const Text(
                            'BOM',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Tooltip(
                            message: 'Add new BOM item',
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              splashRadius: 20,
                              onPressed: () => AddUtils.addBOMItem(
                                context: context,
                                dbh: widget.dbh,
                                part: widget.part,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PartBOMTable(dbh: widget.dbh, part: widget.part),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

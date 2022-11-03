import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:particulous/add_category_form.dart';
import 'package:particulous/add_part_form.dart';
import 'package:particulous/category_screen.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/db/sqlite/sqlite_strategy.dart';
import 'package:particulous/part_widget.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'util/string_util.dart';

class ApplicationDirectories {
  final Directory documentsDir;
  final Directory imageDir;
  ApplicationDirectories(this.documentsDir)
      : imageDir = Directory(join(documentsDir.path, 'particulous', 'image')) {
    imageDir.create(recursive: true);
  }
}

Future<void> main() async {
  final directories =
      await getApplicationDocumentsDirectory().then(ApplicationDirectories.new);

  runApp(
    MultiProvider(
      providers: [
        Provider<DBHandler>(
          create: (context) => DBHandler(strategy: SQLiteStrategy()),
          dispose: (context, dbh) => dbh.close(),
        ),
        Provider<ApplicationDirectories>(
          create: (context) => directories,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Particulous',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyWidget(),
      routes: {
        CategoryScreen.route: (context) => const CategoryScreen(),
      },
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final DBHandler dbh = Provider.of<DBHandler>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parts'),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.category),
            label: 'Category',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('New Category'),
                  ),
                  body: Center(
                    child: SizedBox(
                      width: 500,
                      child: AddCategoryForm(
                        dbHandler: dbh,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SpeedDialChild(
              child: const Icon(Icons.download),
              label: 'Import LCSC Part',
              onTap: () {
                final textFieldController = TextEditingController();
                showDialog<String>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Enter LCSC part number'),
                    content: TextField(
                      onChanged: (value) {},
                      controller: textFieldController,
                      decoration: const InputDecoration(hintText: "LCSC#"),
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Abort'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () =>
                            Navigator.pop(context, textFieldController.text),
                      ),
                    ],
                  ),
                )
                    .then((product) => http.get(Uri(
                          scheme: 'https',
                          host: 'wwwapi.lcsc.com',
                          path: 'v1/products/detail',
                          queryParameters: {'product_code': product},
                        )))
                    .then((response) => jsonDecode(response.body))
                    .then((json) => Future.wait([
                          Future.value(json),
                          fetchImage(json['productImages'])
                        ]))
                    .then((values) {
                  final json = values[0] as dynamic;
                  if (json is List<dynamic>) {
                    log('Part not found');
                    return;
                  }
                  final name = json['productModel'];
                  final description = json['productIntroEn'];
                  final image = values[1] as PlatformFile?;

                  if (name == null || description == null) {
                    log('Could not find needed data');
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('Import LCSC Part'),
                        ),
                        body: Center(
                          child: SizedBox(
                            width: 500,
                            child: AddPartForm(
                              dbHandler: dbh,
                              name: name,
                              description: description,
                              images: image == null ? [] : [image],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
              }),
          SpeedDialChild(
            child: const Icon(Icons.article),
            label: 'Part',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: const Text('New Part'),
                  ),
                  body: Center(
                    child: SizedBox(
                      width: 500,
                      child: AddPartForm(
                        dbHandler: dbh,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Part>>(
        stream: dbh.watchParts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length + 1,
                itemBuilder: (context, index) {
                  if (index == snapshot.data!.length) {
                    return const SizedBox(
                      height: 200.0,
                    );
                  }
                  return PartWidget(
                    dbh: dbh,
                    part: snapshot.data![index],
                    clickableCategories: true,
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<PlatformFile?> fetchImage(List<dynamic> images) async {
    String? image;
    String? imageName;
    int? imageSize;
    if (images.isNotEmpty) {
      image = images.first;
      final response = await http.get(Uri.parse(image!));
      // final dirs = Provider.of<ApplicationDirectories>(context,
      //     listen: false);
      imageName = '${StringUtil.random(10)}.jpg';
      image = join(Directory.systemTemp.path, imageName);
      final imageFile = File(image);
      imageFile.writeAsBytesSync(response.bodyBytes);
      imageSize = imageFile.lengthSync();
    }
    return PlatformFile(
      name: imageName!,
      size: imageSize!,
      path: image,
    );
  }
}

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:particulous/add_bom_part_form.dart';
import 'package:particulous/add_category_form.dart';
import 'package:particulous/add_location_form.dart';
import 'package:particulous/add_part_form.dart';
import 'package:particulous/add_stock_form.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:http/http.dart' as http;
import 'package:particulous/util/loading_overlay.dart';
import 'package:particulous/util/string_util.dart';
import 'package:path/path.dart';

abstract class AddUtils {
  static void addPart({
    required final BuildContext context,
    required final DBHandler dbh,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('New Part'),
            ),
            body: Center(
              child: SizedBox(
                width: 500,
                child: AddPartForm(dbHandler: dbh),
              ),
            ),
          ),
        ),
      );

  static void addLCSCPart({
    required final BuildContext context,
    required final DBHandler dbh,
  }) {
    final textFieldController = TextEditingController();
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter LCSC part number'),
        content: TextField(
          autofocus: true,
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
            onPressed: () => Navigator.pop(context, textFieldController.text),
          ),
        ],
      ),
    )
        .then((part) => LoadingOverlay.of(context).during(
              http
                  .get(Uri(
                    scheme: 'https',
                    host: 'wwwapi.lcsc.com',
                    path: 'v1/products/detail',
                    queryParameters: {'product_code': part},
                  ))
                  .then((response) => jsonDecode(response.body))
                  .then((json) {
                final images = json['productImages'];
                return Future.wait([
                  Future.value(json),
                  images == null ? Future.value(null) : fetchImage(images)
                ]);
              }),
            ))
        .then((values) {
      final json = values[0] as dynamic;
      if (json == null || json is List<dynamic>) {
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
    }).catchError((error) {
      log('Error: $error');
      return null;
    });
  }

  static void addCategory({
    required final BuildContext context,
    required final DBHandler dbh,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('New Category'),
            ),
            body: Center(
              child: SizedBox(
                width: 500,
                child: AddCategoryForm(dbHandler: dbh),
              ),
            ),
          ),
        ),
      );

  static void addStock({
    required final BuildContext context,
    required final DBHandler dbh,
    Part? part,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('New Stock'),
            ),
            body: Center(
              child: SizedBox(
                width: 500,
                child: AddStockForm(
                  dbHandler: dbh,
                  initialPart: part,
                ),
              ),
            ),
          ),
        ),
      );

  static void addLocation({
    required final BuildContext context,
    required final DBHandler dbh,
    Part? part,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('New Location'),
            ),
            body: Center(
              child: SizedBox(
                width: 500,
                child: AddLocationForm(
                  dbHandler: dbh,
                ),
              ),
            ),
          ),
        ),
      );

  static Future<PlatformFile?> fetchImage(List<dynamic> images) async {
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

  static void addBOMItem(
          {required BuildContext context,
          required DBHandler dbh,
          required Part? part}) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Add BOM item'),
            ),
            body: Center(
              child: SizedBox(
                width: 500,
                child: AddBOMPartForm(
                  dbHandler: dbh,
                  initialParent: part,
                ),
              ),
            ),
          ),
        ),
      );
}

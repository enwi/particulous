import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:particulous/form/add_bom_part_form.dart';
import 'package:particulous/form/add_build_order_form.dart';
import 'package:particulous/form/add_category_form.dart';
import 'package:particulous/form/add_location_form.dart';
import 'package:particulous/form/add_part_form.dart';
import 'package:particulous/form/add_stock_form.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:http/http.dart' as http;
import 'package:particulous/util/loading_overlay.dart';
import 'package:particulous/util/string_util.dart';
import 'package:path/path.dart';

abstract class AddUtils {
  static Future _pushForm({
    required final BuildContext context,
    required final String title,
    required final Widget child,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: 500,
                  padding: const EdgeInsets.only(
                      left: 16, top: 16, right: 16, bottom: 32),
                  child: child,
                ),
              ),
            ),
          ),
        ),
      );

  static void addPart({
    required final BuildContext context,
    required final DBHandler dbh,
  }) =>
      _pushForm(
        context: context,
        title: 'New Part',
        child: AddPartForm(dbHandler: dbh),
      ).then((value) => log('Added new part $value'));

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

  static void addLCSCPart({
    required final BuildContext context,
    required final DBHandler dbh,
    final String? part,
    final int? amount,
  }) {
    final textFieldController = TextEditingController();
    (part != null
            ? Future.value(part)
            : showDialog<String>(
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
                      onPressed: () =>
                          Navigator.pop(context, textFieldController.text),
                    ),
                  ],
                ),
              ))
        .then((part) => LoadingOverlay.of(context).during(
              http
                  .get(Uri(
                    scheme: 'https',
                    host: 'wmsc.lcsc.com',
                    path: 'ftps/wm/product/detail',
                    queryParameters: {'productCode': part},
                  ))
                  .then(
                      (response) => jsonDecode(utf8.decode(response.bodyBytes)))
                  .then((json) {
                final images = json['result']?['productImages'];
                return Future.wait([
                  Future.value(json),
                  images == null || images.isEmpty
                      ? Future.value(null)
                      : fetchImage(images)
                ]);
              }),
            ))
        .then((values) {
      var json = values[0] as dynamic;
      if (json == null || json is List<dynamic>) {
        log('Part not found');
        return;
      }
      json = json['result'];
      if (json == null || json is List<dynamic>) {
        log('Part not found');
        return;
      }

      final name = json['title'];
      final description = json['productIntroEn'];
      final sku = json['productCode'];
      final mpn = json['productModel'];
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
            body: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: 500,
                  child: AddPartForm(
                    dbHandler: dbh,
                    name: name,
                    description: description,
                    sku: sku,
                    mpn: mpn,
                    images: image == null ? [] : [image],
                  ),
                ),
              ),
            ),
          ),
        ),
      ).then((value) {
        if (value != null) {
          Navigator.of(context).pushNamed('/parts/$value');
        }
      });
    }).catchError((error) {
      log('Error: $error');
      return null;
    });
  }

  static void addCategory({
    required final BuildContext context,
    required final DBHandler dbh,
  }) =>
      _pushForm(
        context: context,
        title: 'New Category',
        child: AddCategoryForm(dbHandler: dbh),
      );

  static void addStock({
    required final BuildContext context,
    required final DBHandler dbh,
    Part? part,
  }) =>
      _pushForm(
        context: context,
        title: 'New Stock',
        child: AddStockForm(
          dbHandler: dbh,
          initialPart: part,
        ),
      );

  static void addLocation({
    required final BuildContext context,
    required final DBHandler dbh,
    Part? part,
  }) =>
      _pushForm(
        context: context,
        title: 'New Location',
        child: AddLocationForm(dbHandler: dbh),
      );

  static void addBOMItem({
    required BuildContext context,
    required DBHandler dbh,
    Part? part,
  }) =>
      _pushForm(
        context: context,
        title: 'New BOM Item',
        child: AddBOMPartForm(
          dbHandler: dbh,
          initialParent: part,
        ),
      );

  static void addBuildOrder({
    required BuildContext context,
    required DBHandler dbh,
    Part? part,
  }) =>
      _pushForm(
        context: context,
        title: 'New Build Order',
        child: AddBuildOrderForm(
          dbHandler: dbh,
          initialPart: part,
        ),
      );
}

import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'add_category_form.dart';
import 'add_part_form.dart';
import 'data/part.dart';
import 'db/db_handler.dart';
import 'part_detail_screen.dart';
import 'part_widget.dart';
import 'util/string_util.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    final DBHandler dbh = Provider.of<DBHandler>(context);
    return StreamBuilder<List<Part>>(
      stream: dbh.watchParts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final parts = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Parts'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => showSearch(
                    context: context,
                    delegate: DataSearch(
                      dbh: dbh,
                      parts: parts,
                    ),
                  ),
                ),
              ],
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
                            child: AddCategoryForm(dbHandler: dbh),
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
                            decoration:
                                const InputDecoration(hintText: "LCSC#"),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Abort'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () => Navigator.pop(
                                  context, textFieldController.text),
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
                          .then((json) {
                        final images = json['productImages'];
                        return Future.wait([
                          Future.value(json),
                          images == null
                              ? Future.value(null)
                              : fetchImage(images)
                        ]);
                      }).then((values) {
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
                            child: AddPartForm(dbHandler: dbh),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: ListView.builder(
                itemCount: parts.length + 1,
                itemBuilder: (context, index) {
                  if (index == parts.length) {
                    return const SizedBox(
                      height: 200.0,
                    );
                  }
                  return PartWidget(
                    dbh: dbh,
                    part: parts[index],
                    clickableCategories: true,
                  );
                }),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
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

class DataSearch extends SearchDelegate<String> {
  final DBHandler dbh;
  final List<Part> parts;

  DataSearch({required this.dbh, required this.parts});

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, '');
            }
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    final suggestionList = query.isEmpty
        ? parts
        : parts
            .where((p) => p.name.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => PartWidget(
        dbh: dbh,
        part: suggestionList[index],
        onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PartDetailScreen(dbh: dbh, part: suggestionList[index]),
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => FutureBuilder(
        future: dbh.fetchSearchSuggestions(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final suggestions = snapshot.data!;
            return ListView.builder(
              itemCount: suggestions.length,
              itemBuilder: (context, index) => ListTile(
                title: RichText(text: searchMatch(query, suggestions[index])),
                trailing: const Icon(Icons.search),
                onTap: () {
                  query = suggestions[index];
                  showResults(context);
                },
              ),
            );
          }
          return const LinearProgressIndicator();
        },
      );
}

const positiveColorStyle = TextStyle(color: Colors.blue);
const negativeColorStyle = TextStyle(color: Colors.black);

TextSpan searchMatch(final String search, final String match) {
  if (search.isEmpty) {
    return TextSpan(text: match, style: negativeColorStyle);
  }
  var refinedMatch = match.toLowerCase();
  var refinedSearch = search.toLowerCase();
  if (refinedMatch.contains(refinedSearch)) {
    if (refinedMatch.substring(0, refinedSearch.length) == refinedSearch) {
      return TextSpan(
        style: positiveColorStyle,
        text: match.substring(0, refinedSearch.length),
        children: [
          searchMatch(
            search,
            match.substring(
              refinedSearch.length,
            ),
          ),
        ],
      );
    } else if (refinedMatch.length == refinedSearch.length) {
      return TextSpan(text: match, style: positiveColorStyle);
    } else {
      return TextSpan(
        style: negativeColorStyle,
        text: match.substring(
          0,
          refinedMatch.indexOf(refinedSearch),
        ),
        children: [
          searchMatch(
            search,
            match.substring(
              refinedMatch.indexOf(refinedSearch),
            ),
          ),
        ],
      );
    }
  } else if (!refinedMatch.contains(refinedSearch)) {
    return TextSpan(text: match, style: negativeColorStyle);
  }
  return TextSpan(
    text: match.substring(0, refinedMatch.indexOf(refinedSearch)),
    style: negativeColorStyle,
    children: [
      searchMatch(search, match.substring(refinedMatch.indexOf(refinedSearch)))
    ],
  );
}

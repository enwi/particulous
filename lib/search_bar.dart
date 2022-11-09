import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:particulous/data/part.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_detail_screen.dart';
import 'package:particulous/part/part_widget.dart';
import 'package:particulous/settings_screen.dart';
import 'package:particulous/util/add_utils.dart';
import 'package:provider/provider.dart';

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
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()),
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
                  onTap: () => AddUtils.addCategory(
                    context: context,
                    dbh: dbh,
                  ),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.download),
                  label: 'Import LCSC Part',
                  onTap: () => AddUtils.addLCSCPart(
                    context: context,
                    dbh: dbh,
                  ),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.article),
                  label: 'Part',
                  onTap: () => AddUtils.addPart(
                    context: context,
                    dbh: dbh,
                  ),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.bar_chart),
                  label: 'Stock',
                  onTap: () => AddUtils.addStock(
                    context: context,
                    dbh: dbh,
                  ),
                ),
                SpeedDialChild(
                  child: const Icon(Icons.location_on),
                  label: 'Location',
                  onTap: () => AddUtils.addLocation(
                    context: context,
                    dbh: dbh,
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
  Widget buildResults(BuildContext context) => FutureBuilder(
        future: dbh.fetchSearchParts(query),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final parts = snapshot.data!;
            return ListView.builder(
              itemCount: parts.length,
              itemBuilder: (context, index) => PartWidget(
                dbh: dbh,
                part: parts[index],
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PartDetailScreen(dbh: dbh, part: parts[index]),
                  ),
                ),
              ),
            );
          }
          return const LinearProgressIndicator();
        },
      );

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

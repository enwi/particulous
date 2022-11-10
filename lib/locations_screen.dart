import 'package:flutter/material.dart';
import 'package:particulous/create_action_button.dart';
import 'package:particulous/data/location.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/part/part_detail_screen.dart';
import 'package:particulous/part/part_widget.dart';
import 'package:particulous/settings_screen.dart';
import 'package:particulous/util/my_drawer.dart';
import 'package:provider/provider.dart';

class LocationsScreen extends StatefulWidget {
  static const String route = '/locations';

  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    final DBHandler dbh = Provider.of<DBHandler>(context);
    return StreamBuilder<List<Location>>(
      stream: dbh.watchLocations(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final locations = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Locations'),
              actions: [
                const IconButton(
                  icon: Icon(Icons.search),
                  onPressed: null,
                  // onPressed: () => showSearch(
                  //   context: context,
                  //   delegate: LocationsSearch(
                  //     dbh: dbh,
                  //   ),
                  // ),
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
            drawer: getDrawer(context),
            floatingActionButton: CreateActionButton(dbh: dbh),
            body: ListView.builder(
                itemCount: locations.length + 1,
                itemBuilder: (context, index) {
                  if (index == locations.length) {
                    return const SizedBox(
                      height: 200.0,
                    );
                  }
                  final location = locations[index];
                  return ListTile(
                    title: Text(location.name),
                    subtitle: Text(location.id.toString()),
                  );
                }),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class LocationSearch extends SearchDelegate<String> {
  final DBHandler dbh;

  LocationSearch({required this.dbh});

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

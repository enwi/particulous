import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:particulous/locations_screen.dart';
import 'package:particulous/parts_screen.dart';
import 'package:provider/provider.dart';

Drawer getDrawer(final BuildContext context) => Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.indigo,
            ),
            child: Consumer<PackageInfo>(
              builder: (context, value, child) => ListTile(
                  title: const Text('Particoulus'),
                  subtitle: Text('v${value.version}+${value.buildNumber}')),
            ),
          ),
          ListTile(
            title: const Text('Parts'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              PartsScreen.route,
              (route) => route.isFirst,
            ),
          ),
          ListTile(
            title: const Text('Locations'),
            onTap: () => Navigator.pushNamedAndRemoveUntil(
              context,
              LocationsScreen.route,
              (route) => route.isFirst,
            ),
          ),
        ],
      ),
    );

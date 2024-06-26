import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:particulous/camera.dart';
import 'package:particulous/db/db_handler.dart';
import 'package:particulous/util/add_utils.dart';

class CreateActionButton extends StatelessWidget {
  const CreateActionButton({
    super.key,
    required this.dbh,
  });

  final DBHandler dbh;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
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
        SpeedDialChild(
          child: const Icon(Icons.qr_code),
          label: 'QR',
          onTap: () => scanQR(context).then((data) => parseQR(data ?? '')).then(
            (value) {
              if (value is LCSCQRData) {
                AddUtils.addLCSCPart(
                  context: context,
                  dbh: dbh,
                  part: value.productNumber,
                  amount: value.amount,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

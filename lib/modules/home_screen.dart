import 'package:adminpanel/core/widgets/my_buttons.dart';
import 'package:adminpanel/core/widgets/placement_tile.dart';
import 'package:adminpanel/modules/placement/add_placement_message.dart';
import 'package:adminpanel/modules/update_core_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Academia Admin Panel')),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            MyElevatedBtn(
              'Update Core JSON Data',
              () => Get.to(() => UpdateCoreData()),
            ),
            MyElevatedBtn(
              'Add Placement Message',
              () => Get.to(() => AddPlacementMessage()),
            ),
            const PlacementTile()
          ],
        ),
      )),
    );
  }
}

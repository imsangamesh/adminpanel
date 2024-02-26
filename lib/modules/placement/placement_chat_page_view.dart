import 'package:adminpanel/core/constants/constants.dart';
import 'package:adminpanel/core/constants/pref_keys.dart';
import 'package:adminpanel/core/utils/popup.dart';
import 'package:adminpanel/models/placement_msg_model.dart';
import 'package:adminpanel/modules/placement/add_placement_message.dart';
import 'package:adminpanel/modules/placement/placement_chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlacementChatPageView extends StatelessWidget {
  const PlacementChatPageView(this.year, {super.key});

  final String year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$year Placement Updates')),
      body: StreamBuilder(
        stream: fire
            .collection(FireKeys.placementMsgs)
            .doc(year)
            .collection(FireKeys.messages)
            .orderBy('createdAt')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final msgSnap = snapshot.data;

            if (msgSnap == null || msgSnap.docs.isEmpty) {
              return Popup.nill('Oops! No updates yet!');
            }

            return ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: msgSnap.docs.length,
              itemBuilder: (context, index) {
                final msgData = msgSnap.docs[index].data();
                final msgModel = PlacementMsgModel.fromMap(msgData);

                return PlacementChatTile(msgModel, year);
              },
            );
          } else {
            return const Center(child: Text('...'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.to(() => AddPlacementMessage()),
        label: const Text('new'),
      ),
    );
  }
}

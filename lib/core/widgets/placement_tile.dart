import 'package:adminpanel/core/themes/app_colors.dart';
import 'package:adminpanel/core/themes/app_text_styles.dart';
import 'package:adminpanel/core/widgets/my_buttons.dart';
import 'package:adminpanel/modules/placement/placement_chat_page_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlacementTile extends StatelessWidget {
  const PlacementTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ExpansionTile(
          textColor: AppColors.mid,
          initiallyExpanded: true,
          childrenPadding: const EdgeInsets.all(10),
          expandedAlignment: Alignment.centerLeft,
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          title: const Text('Placement Updates', style: AppTStyles.subHeading),
          children: [
            MyOutlinedBtn(
              'First Year   >',
              () => Get.to(() => const PlacementChatPageView('First Year')),
              icon: Icons.looks_one,
            ),
            MyOutlinedBtn(
              'Second Year   >',
              () => Get.to(() => const PlacementChatPageView('Second Year')),
              icon: Icons.looks_two,
            ),
            MyOutlinedBtn(
              'Third Year   >',
              () => Get.to(() => const PlacementChatPageView('Third Year')),
              icon: Icons.looks_3,
            ),
            MyOutlinedBtn(
              'Final Year   >',
              () => Get.to(() => const PlacementChatPageView('Final Year')),
              icon: Icons.looks_4,
            ),
          ],
        ),
      ),
    );
  }
}

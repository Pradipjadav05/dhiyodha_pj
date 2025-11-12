import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrainingPage extends StatefulWidget {
  TrainingPageState createState() => TrainingPageState();
}

class TrainingPageState extends State<TrainingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text("Training".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: paddingSize20,
            ),
            Expanded(
              child: Center(
                child: Text(
                  "coming_soon".tr,
                  style: fontBold.copyWith(
                      fontSize: fontSize20, color: midnightBlue),
                ),
              ),
            )
            // Expanded(
            //   child: ListView.builder(
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(paddingSize8),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Row(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Expanded(
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     mainAxisSize: MainAxisSize.min,
            //                     children: [
            //                       Text(
            //                         "1 Hour of BNI Podcasts, Webinars, BNI Sucessnet, Etc.",
            //                         style: fontBold.copyWith(
            //                             color: midnightBlue,
            //                             fontSize: fontSize16),
            //                       ),
            //                       SizedBox(height: paddingSize15),
            //                       Row(
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         mainAxisSize: MainAxisSize.max,
            //                         children: [
            //                           Text(
            //                             "Credits/Course : 1",
            //                             style: fontRegular.copyWith(
            //                                 color: bluishPurple,
            //                                 fontSize: fontSize12),
            //                           ),
            //                           SizedBox(width: paddingSize15),
            //                           Text(
            //                             "Total : 0",
            //                             style: fontRegular.copyWith(
            //                                 color: bluishPurple,
            //                                 fontSize: fontSize12),
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //                 Card(
            //                   color: lavenderMist,
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: paddingSize20,
            //                         vertical: paddingSize10),
            //                     child: Text("0",
            //                         style: fontBold.copyWith(
            //                             color: bluishPurple,
            //                             fontSize: fontSize26)),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             SizedBox(
            //               height: paddingSize20,
            //             ),
            //             index != index - 1
            //                 ? Divider(thickness: 0.5)
            //                 : Container()
            //           ],
            //         ),
            //       );
            //     },
            //     itemCount: 0,
            //   ),
            // )
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/viewModel/visitors_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListVisitorsPage extends StatefulWidget {
  final VisitorsViewModel visitorsViewModel;
  final VoidCallback onStateChanged;

  const ListVisitorsPage({
    Key? key,
    required this.visitorsViewModel,
    required this.onStateChanged,
  }) : super(key: key);

  @override
  State<ListVisitorsPage> createState() => _ListVisitorsPageState();
}

class _ListVisitorsPageState extends State<ListVisitorsPage> {
  VisitorsViewModel get vvm => widget.visitorsViewModel;

  // Track which item is expanded (-1 means none)
  final RxInt expandedIndex = (-1).obs;

  // Sample data for testing - replace with actual data later
  final List<String> sampleVisitors = [
    "John Doe",
    "Jane Smith",
    "Robert Johnson",
    "Emily Davis",
    "Michael Wilson",
    "Sarah Brown",
    "David Miller",
    "Lisa Anderson",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Visitor List
        Expanded(
          child: sampleVisitors.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 80,
                        color: greyText.withValues(alpha: 0.5),
                      ),
                      const SizedBox(height: paddingSize20),
                      Text(
                        "no_visitors_found".tr,
                        style: fontMedium.copyWith(
                            color: greyText, fontSize: fontSize16),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize14, vertical: paddingSize10),
                  itemCount: sampleVisitors.length,
                  itemBuilder: (context, index) {
                    final visitorName = sampleVisitors[index];
                    return Obx(() {
                      final isExpanded = expandedIndex.value == index;

                      return Container(
                        margin: const EdgeInsets.only(bottom: paddingSize10),
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(radius10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: paddingSize15,
                                  vertical: paddingSize10),
                              leading: CircleAvatar(
                                backgroundColor:
                                    midnightBlue.withValues(alpha: 0.1),
                                radius: 25,
                                child: Text(
                                  visitorName[0].toUpperCase(),
                                  style: fontBold.copyWith(
                                      color: midnightBlue,
                                      fontSize: fontSize18),
                                ),
                              ),
                              title: Text(
                                visitorName,
                                style: fontMedium.copyWith(
                                    color: midnightBlue, fontSize: fontSize16),
                              ),
                              subtitle: Text(
                                visitorName,
                                style: fontMedium.copyWith(
                                    color: greyText, fontSize: fontSize14),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      // Call action
                                    },
                                    icon: Icon(Icons.call,
                                        color: Colors.green, size: iconSize22),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      expandedIndex.value =
                                          isExpanded ? -1 : index;
                                    },
                                    icon: AnimatedRotation(
                                      turns: isExpanded ? 0.25 : 0,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: midnightBlue,
                                        size: iconSize18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Expandable Section
                            AnimatedCrossFade(
                              firstChild: const SizedBox.shrink(),
                              secondChild: _buildExpandedDetails(index),
                              crossFadeState: isExpanded
                                  ? CrossFadeState.showSecond
                                  : CrossFadeState.showFirst,
                              duration: const Duration(milliseconds: 200),
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildExpandedDetails(int index) {
    return Padding(
      padding: const EdgeInsets.only(
          left: paddingSize15, right: paddingSize15, bottom: paddingSize15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            icon: Icons.phone_outlined,
            title: "contact_number".tr,
            value: "+91 98765 4321$index",
          ),
          _buildDetailRow(
            icon: Icons.business_outlined,
            title: "company_name".tr,
            value: "ABC Company Pvt Ltd",
          ),
          _buildDetailRow(
            icon: Icons.category_outlined,
            title: "business_category".tr,
            value: "IT Services",
          ),
          _buildDetailRow(
            icon: Icons.credit_card_outlined,
            title: "v_card".tr,
            value: "View V-Card",
            isClickable: true,
            onTap: () {
              // Handle V-Card tap
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    required String value,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: greyText.withValues(alpha: 0.3), height: 1),
        const SizedBox(height: paddingSize10),
        Row(
          children: [
            Icon(icon, size: iconSize18, color: greyText),
            const SizedBox(width: paddingSize8),
            Text(
              title,
              style: fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
          ],
        ),
        const SizedBox(height: paddingSize5),
        Padding(
          padding: const EdgeInsets.only(left: paddingSize25),
          child: isClickable
              ? GestureDetector(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: fontMedium.copyWith(
                        color: bluishPurple,
                        fontSize: fontSize14,
                        decoration: TextDecoration.underline),
                  ),
                )
              : Text(
                  value,
                  style: fontMedium.copyWith(
                      color: midnightBlue, fontSize: fontSize14),
                ),
        ),
        const SizedBox(height: paddingSize10),
      ],
    );
  }
}

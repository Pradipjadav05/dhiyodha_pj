import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/viewModel/attendance_viewmodel.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

import '../../utils/resource/app_dimensions.dart';
import '../../utils/resource/app_font_size.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    Get.find<AttendanceViewModel>().initData();
    Get.find<AttendanceViewModel>().getAttendanceList(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CommonAppBar(
          title: Text("attendance".tr),
        ),
      ),
      body: GetBuilder<AttendanceViewModel>(builder: (attendanceVM) {
        return Column(
          children: [
            if (attendanceVM.isLoading || attendanceVM.isHistoryLoading)
              LinearProgressIndicator(
                color: midnightBlue,
                backgroundColor: lavenderMist,
                minHeight: 3,
                borderRadius: BorderRadius.circular(radius20),
              ),
            _buildTabSelector(attendanceVM),
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildActiveAttendance(attendanceVM)
                  : _buildAttendanceHistory(attendanceVM),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTabSelector(AttendanceViewModel attendanceVM) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE3E8F4),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          _tabPill(
            label: "attendance".tr,
            isActive: _selectedTabIndex == 0,
            onTap: () {
              setState(() {
                _selectedTabIndex = 0;
              });
            },
          ),
          _tabPill(
            label: "attendance_history".tr,
            isActive: _selectedTabIndex == 1,
            onTap: () {
              setState(() {
                _selectedTabIndex = 1;
              });
              if (attendanceVM.attendanceHistoryList.isEmpty) {
                attendanceVM.getAttendanceHistory(0, 10);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _tabPill({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? midnightBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActiveAttendance(AttendanceViewModel attendanceVM) {
    if (attendanceVM.attendanceList.isEmpty) {
      if (attendanceVM.isLoading) {
        return const SizedBox.shrink();
      }
      return Center(
        child: Text("No records found", style: fontRegular.copyWith(fontSize: fontSize14)),
      );
    }

    return LoadMore(
      isFinish: attendanceVM.page.value >= attendanceVM.totalPages.value,
      onLoadMore: attendanceVM.loadMore,
      textBuilder: DefaultLoadMoreTextBuilder.english,
      child: ListView.builder(
        padding: EdgeInsets.only(left: paddingSize14, right: paddingSize14, bottom: paddingSize14),
        itemCount: attendanceVM.attendanceList.length,
        itemBuilder: (context, index) {
          return _attendanceCard(attendanceVM.attendanceList[index]);
        },
      ),
    );
  }

  Widget _buildAttendanceHistory(AttendanceViewModel attendanceVM) {
    if (attendanceVM.attendanceHistoryList.isEmpty) {
      if (attendanceVM.isHistoryLoading) {
        return const SizedBox.shrink();
      }
      return Center(
        child: Text("No records found", style: fontRegular.copyWith(fontSize: fontSize14)),
      );
    }

    return LoadMore(
      isFinish: attendanceVM.historyPage.value >= attendanceVM.historyTotalPages.value,
      onLoadMore: attendanceVM.loadMoreHistory,
      textBuilder: DefaultLoadMoreTextBuilder.english,
      child: ListView.builder(
        padding: EdgeInsets.only(left: paddingSize14, right: paddingSize14, bottom: paddingSize14),
        itemCount: attendanceVM.attendanceHistoryList.length,
        itemBuilder: (context, index) {
          return _attendanceCard(attendanceVM.attendanceHistoryList[index]);
        },
      ),
    );
  }

  Widget _attendanceCard(item) {
    return CommonCard(
      cardChild: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            item.meeting?.title ?? "",
            style: fontBold.copyWith(fontSize: fontSize16, color: midnightBlue),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: paddingSize8),
              Text(
                item.meeting?.meetingDate ?? "",
                style: fontRegular.copyWith(fontSize: fontSize14, color: greyText),
              ),
              SizedBox(height: paddingSize8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusText("present".tr, item.present ?? 0, successGreen),
                  _statusText("absent".tr, item.absent ?? 0, dangerRed),
                  // _statusText("substitute".tr, item.substitute ?? 0, Colors.orange),
                ],
              ),
            ],
          ),
          children: [
            if (item.memberDetails != null && item.memberDetails!.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item.memberDetails!.length,
                itemBuilder: (context, idx) {
                  var detail = item.memberDetails![idx];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: paddingSize15, vertical: 0),
                    title: Text(
                      detail.memberName ?? "",
                      style: fontRegular.copyWith(fontSize: fontSize14, color: midnightBlue),
                    ),
                    trailing: Container(
                      padding: EdgeInsets.symmetric(horizontal: paddingSize8, vertical: paddingSize5),
                      decoration: BoxDecoration(
                        color: detail.status?.toLowerCase() == 'present'
                            ? successGreen.withValues(alpha:0.1)
                            : detail.status?.toLowerCase() == 'absent'
                                ? dangerRed.withValues(alpha:0.1)
                                : Colors.orange.withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(paddingSize5),
                      ),
                      child: Text(
                        detail.status ?? "",
                        style: fontRegular.copyWith(
                          fontSize: fontSize12,
                          color: detail.status?.toLowerCase() == 'present'
                              ? successGreen
                              : detail.status?.toLowerCase() == 'absent'
                                  ? dangerRed
                                  : Colors.orange,
                        ),
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  Widget _statusText(String title, int count, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: fontRegular.copyWith(fontSize: fontSize12, color: greyText),
        ),
        Text(
          count.toString(),
          style: fontBold.copyWith(fontSize: fontSize16, color: color),
        ),
      ],
    );
  }
}

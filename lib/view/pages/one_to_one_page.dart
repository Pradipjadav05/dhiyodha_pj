import 'package:dhiyodha/model/response_model/one_to_one_response_model.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/viewModel/one_to_one_slip_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OneToOnePage extends StatefulWidget {
  const OneToOnePage({Key? key}) : super(key: key);

  @override
  OneToOnePageState createState() => OneToOnePageState();
}

class OneToOnePageState extends State<OneToOnePage> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await Get.find<OneToOneSlipViewModel>()
        .getOneToOneData(0, 100, 'createdAt', 'DESC');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<OneToOneSlipViewModel>(builder: (oVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "One-to-One Slip".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            tooltip: "Add One-to-One",
            elevation: 4.0,
            backgroundColor: midnightBlue,
            onPressed: () async {
              // ✅ Await navigation, then refresh list
              await Get.toNamed(Routes.getAddOneToOnePageRoute());
              await _fetchData();
            },
            child: Icon(Icons.add, color: periwinkle, size: 32.0),
          ),
          body: oVM.isLoading
              ? Center(
            child: CircularProgressIndicator(color: midnightBlue),
          )
              : oVM.oneToOneDataList.isEmpty
              ? Center(
            child: Text(
              "No records found".tr,
              style: fontRegular.copyWith(
                  fontSize: fontSize14, color: greyText),
            ),
          )
              : ListView.builder(
            shrinkWrap: true,
            itemCount: oVM.oneToOneDataList.length,
            itemBuilder: (context, index) {
              return _oneToOneListItems(index, oVM);
            },
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _oneToOneListItems(int index, OneToOneSlipViewModel oVM) {
    final OneToOneChildData data = oVM.oneToOneDataList[index];

    final String connectedWithName =
    '${data.connectedWith?.firstName ?? ''} ${data.connectedWith?.lastName ?? ''}'
        .trim();
    final String initiatedByName =
    '${data.initiatedBy?.firstName ?? ''} ${data.initiatedBy?.lastName ?? ''}'
        .trim();
    final String mobileNo = data.connectedWith?.mobileNo ?? '';
    final String notes = data.oneToOneNotes ?? '';
    final String date = data.oneToOneDate ?? '';

    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: Obx(
            () => ExpansionTile(
          dense: false,
          shape: const Border(),
          leading: Image.asset(profileImage, width: 48.0, height: 48.0),
          title: Text(
            connectedWithName,
            style: fontBold.copyWith(fontSize: fontSize16, color: midnightBlue),
          ),
          subtitle: Text(
            date,
            style: fontRegular.copyWith(fontSize: fontSize12, color: greyText),
          ),
          onExpansionChanged: (isExpandedItem) {
            oVM.isExpanded.value = isExpandedItem;
          },
          trailing: oVM.isExpanded.value
              ? Image.asset(nextArrow, height: iconSize18, width: iconSize18)
              : Image.asset(dropDownArrow, height: iconSize18, width: iconSize18),
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Contact Number ──
                _detailRow(
                  icon: contact,
                  label: "Contact Number",
                  value: mobileNo,
                ),
                const Divider(thickness: 0.2),

                // ── Initiated By ──
                _detailRow(
                  icon: company,
                  label: "Initiated By",
                  value: initiatedByName,
                ),
                const Divider(thickness: 0.2),

                // ── Notes ──
                _detailRow(
                  icon: businessCat,
                  label: "Notes",
                  value: notes,
                ),
                const Divider(thickness: 0.2),

                // ── V-Card ──
                InkWell(
                  onTap: () {
                    // TODO: handle V-Card tap
                  },
                  child: _detailRow(
                    icon: vCard,
                    label: "V-Card",
                    value: connectedWithName,
                  ),
                ),
                const Divider(thickness: 0.2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Reusable detail row ──
  Widget _detailRow({
    required String icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: paddingSize20, vertical: paddingSize15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(icon, height: iconSize18, width: iconSize18),
              const SizedBox(width: paddingSize5),
              Text(
                label,
                style: fontRegular.copyWith(
                    fontSize: fontSize12, color: midnightBlue),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value.isEmpty ? '—' : value,
            style:
            fontMedium.copyWith(fontSize: fontSize14, color: midnightBlue),
          ),
        ],
      ),
    );
  }
}
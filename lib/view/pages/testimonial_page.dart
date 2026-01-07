import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_snackbar.dart';
import 'package:dhiyodha/viewModel/testimonial_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loadmore/loadmore.dart';

class TestimonialPage extends StatefulWidget {
  TestimonialPageState createState() => TestimonialPageState();
}

class TestimonialPageState extends State<TestimonialPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  Future<void> initData() async {
    TestimonialViewModel testimonialViewModel =
        Get.find<TestimonialViewModel>();
    testimonialViewModel.initData();
    testimonialViewModel.getMyTestimonial(testimonialViewModel.page.value,
        testimonialViewModel.size.value, "", "", "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TestimonialViewModel>(builder: (testimonialVM) {
        return Scaffold(
          backgroundColor: ghostWhite,
          appBar: CommonAppBar(
            title: Text(
              "testimonials_received".tr,
              style: fontBold.copyWith(
                  fontSize: fontSize18,
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
          ),
          body: Column(
            children: [
              Visibility(
                visible: testimonialVM.isLoading,
                child: LinearProgressIndicator(
                  color: midnightBlue,
                  backgroundColor: lavenderMist,
                  borderRadius: BorderRadius.circular(radius20),
                ),
              ),
              testimonialVM.myTestimonialList.isEmpty
                  ? testimonialVM.isLoading
                      ? Container()
                      : Expanded(
                          child: Center(
                            child: Text("no_test_found".tr),
                          ),
                        )
                  : Expanded(
                      child: LoadMore(
                          isFinish: testimonialVM.page.value ==
                              testimonialVM.totalPages.value,
                          whenEmptyLoad: true,
                          delegate: const DefaultLoadMoreDelegate(),
                          textBuilder: DefaultLoadMoreTextBuilder.english,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return _testimonialListItems(
                                  index, testimonialVM);
                            },
                            itemCount: testimonialVM.myTestimonialList.length,
                          ),
                          onLoadMore: testimonialVM.loadMore),
                    ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _refreshUserData(TestimonialViewModel testimonialVM) async {
    try {
      testimonialVM.myTestimonialList = [];
      testimonialVM.page.value = 0;
      testimonialVM.totalPages.value = 0;
      await testimonialVM.getMyTestimonial(
          testimonialVM.page.value, testimonialVM.size.value, "", "", "");
      setState(() {

      });
    } catch (e) {
      print("Error refreshing user data: $e");
    }
  }

  _testimonialListItems(int index, TestimonialViewModel testimonialVM) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: ListTile(
        contentPadding: EdgeInsets.all(paddingSize10),
        onTap: () async {
          Get.toNamed(Routes.getTestimonialDetailsPageRoute(
              testimonialVM.myTestimonialList[index]))?.then((result) {
            if (result == true) {
              _refreshUserData(testimonialVM);
              showSnackBar("testimonials_deleted".tr, isError: false);
            }
          });
        },
        leading: CachedNetworkImage(
          imageUrl:
              '${testimonialVM.myTestimonialList[index].reviewerPofileUrl}',
          width: 62.0,
          height: 62.0,
          fit: BoxFit.fill,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${testimonialVM.myTestimonialList[index].reviewerFirstName} ${testimonialVM.myTestimonialList[index].reviewerLastName}',
              style:
                  fontBold.copyWith(color: midnightBlue, fontSize: fontSize18),
            ),
            Text(
              '${testimonialVM.myTestimonialList[index].type}',
              style: fontMedium.copyWith(color: greyText, fontSize: fontSize12),
            ),
            SizedBox(height: paddingSize5),
            Text(
              '${testimonialVM.myTestimonialList[index].review}',
              style:
                  fontRegular.copyWith(color: greyText, fontSize: fontSize12),
            ),
          ],
        ),
        trailing: Image.asset(
          nextArrow,
          width: iconSize18,
          height: iconSize18,
        ),
      ),
    );
  }
}

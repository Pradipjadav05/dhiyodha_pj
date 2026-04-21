import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_button.dart';
import 'package:dhiyodha/view/widgets/common_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestTestimonialPage extends StatefulWidget {
  RequestTestimonialPageState createState() => RequestTestimonialPageState();
}

class RequestTestimonialPageState extends State<RequestTestimonialPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ghostWhite,
      appBar: CommonAppBar(
        title: Text(
          "Ask Testimonial".tr,
          style: fontBold.copyWith(
              fontSize: fontSize18,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(paddingSize14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Message :",
                  style: fontBold.copyWith(
                      color: midnightBlue, fontSize: fontSize18),
                ),
                SizedBox(height: paddingSize5),
                Divider(),
                SizedBox(height: paddingSize15),
                Row(
                  children: [
                    Text(
                      "* ",
                      style: fontBold.copyWith(
                          color: requiredField, fontSize: fontSize12),
                    ),
                    Text(
                      "Required Field",
                      style: fontRegular.copyWith(
                          color: greyText, fontSize: fontSize12),
                    )
                  ],
                ),
                SizedBox(height: paddingSize15),
                CommonTextFormField(
                  bgColor: lavenderMist,
                  maxLines: 5,
                  hintText:
                      "Hi Kevin,\n Can you please give me a testimonial?\nBest Regards,\nPriya Patel"
                          .tr,
                  textStyle: fontRegular.copyWith(
                      color: midnightBlue, fontSize: fontSize12),
                  padding: const EdgeInsets.symmetric(
                      horizontal: paddingSize20, vertical: paddingSize40),
                ),
                SizedBox(height: paddingSize55),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        fontSize: fontSize14,
                        buttonText: "Submit".tr,
                        bgColor: midnightBlue,
                        textColor: periwinkle,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: paddingSize15),
                    Expanded(
                      child: CommonButton(
                        fontSize: fontSize14,
                        buttonText: "Close".tr,
                        bgColor: lavenderMist,
                        textColor: bluishPurple,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

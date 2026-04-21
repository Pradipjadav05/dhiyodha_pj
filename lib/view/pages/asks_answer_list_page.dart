import 'package:dhiyodha/model/response_model/ask_answers_response_model.dart';
import 'package:dhiyodha/model/response_model/ask_list_response_model.dart';
import 'package:dhiyodha/utils/helper/date_converter.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_dimensions.dart';
import 'package:dhiyodha/utils/resource/app_font_size.dart';
import 'package:dhiyodha/view/widgets/common_app_bar.dart';
import 'package:dhiyodha/view/widgets/common_card.dart';
import 'package:dhiyodha/viewModel/asks_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AsksAnswerListPage extends StatefulWidget {
  AskListChild askChild;

  AsksAnswerListPageState createState() => AsksAnswerListPageState();

  AsksAnswerListPage({required this.askChild});
}

class AsksAnswerListPageState extends State<AsksAnswerListPage> {
  @override
  void initState() {
    super.initState();
    callInitAPIs();
  }

  Future<void> callInitAPIs() async {
    AsksViewModel asksViewModel = Get.find<AsksViewModel>();
    await asksViewModel.initData();
    await asksViewModel.getAsksAnswerList(widget.askChild.askUuid ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AsksViewModel>(builder: (askVM) {
      return Scaffold(
        backgroundColor: ghostWhite,
        appBar: CommonAppBar(
          title: Text(
            "answers".tr,
            style: fontBold.copyWith(
                fontSize: fontSize18,
                color: Theme.of(context).textTheme.bodyLarge!.color),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Visibility(
                visible: askVM.isLoading,
                child: LinearProgressIndicator(
                  color: midnightBlue,
                  backgroundColor: lavenderMist,
                  borderRadius: BorderRadius.circular(radius20),
                ),
              ),
              askVM.answerList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _askAnswersListItems(askVM.answerList[index]);
                        },
                        itemCount: askVM.answerList.length,
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: Text(
                          "no_ask_ans".tr,
                          style: fontMedium.copyWith(
                              color: midnightBlue, fontSize: fontSize18),
                        ),
                      ),
                    )
            ],
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _askAnswersListItems(AnswerList ansObj) {
    return Padding(
      padding: const EdgeInsets.all(paddingSize5),
      child: CommonCard(
        bgColor: white,
        elevation: 2.0,
        cardChild: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(paddingSize8),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: paddingSize15),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${ansObj.answer ?? ""}',
                          style: fontBold.copyWith(
                              fontSize: fontSize16, color: midnightBlue),
                        ),
                        Text(
                          '${DateConverter.convertDateToDate(ansObj.answerAt ?? '')}',
                          style: fontMedium.copyWith(
                              fontSize: fontSize12, color: bluishPurple),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

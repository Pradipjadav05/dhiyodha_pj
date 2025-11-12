import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dhiyodha/utils/helper/routes.dart';
import 'package:dhiyodha/utils/resource/app_colors.dart';
import 'package:dhiyodha/utils/resource/app_media_assets.dart';
import 'package:dhiyodha/viewModel/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription<List<ConnectivityResult>> _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged =
        Connectivity().onConnectivityChanged.listen((result) {
      if (!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi &&
            result != ConnectivityResult.mobile;
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection'.tr : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
        if (!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });
    _route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: midnightBlue,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            appLogo,
            height: 120.0,
            width: 120.0,
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _onConnectivityChanged.cancel();
  }

  void _route() {
    Get.find<SplashViewModel>().initData().then((isSuccess) {
      if (isSuccess) {
        Timer(const Duration(seconds: 4), () async {
          if (Get.find<SplashViewModel>().isLoggedIn()) {
            Get.find<SplashViewModel>().login();
            Get.offNamed(Routes.getHomePageRoute());
          } else {
            Get.offNamed(Routes.getAuthenticationPageRoute());
          }

          // double? minimumVersion = 0;
          // if(GetPlatform.isAndroid) {
          //   minimumVersion = Get.find<SplashController>().configModel!.appMinimumVersionAndroid;
          // }else if(GetPlatform.isIOS) {
          //   minimumVersion = Get.find<SplashController>().configModel!.appMinimumVersionIos;
          // }
          // if(AppConstants.appVersion < minimumVersion! || Get.find<SplashController>().configModel!.maintenanceMode!) {
          //   Get.toNamed(RouteHelper.getUpdateRoute(AppConstants.appVersion < minimumVersion));
          // }else{
          //   if(widget.body != null){
          //     if (widget.body!.notificationType == NotificationType.order) {
          //       Get.toNamed(RouteHelper.getOrderDetailsRoute(widget.body!.orderId, fromNotification: true));
          //     }else if(widget.body!.notificationType == NotificationType.general){
          //       Get.toNamed(RouteHelper.getNotificationRoute(fromNotification: true));
          //     } else {
          //       Get.toNamed(RouteHelper.getChatRoute(notificationBody: widget.body, conversationId: widget.body!.conversationId, fromNotification: true));
          //     }
          //   }else {
          //     if (Get.find<AuthController>().isLoggedIn()) {
          //       Get.find<AuthController>().updateToken();
          //       await Get.find<AuthController>().getProfile();
          //       Get.toNamed(RouteHelper.getInitialRoute());
          //     } else {
          //       if(AppConstants.languages.length > 1 && Get.find<SplashController>().showIntro()) {
          //         Get.toNamed(RouteHelper.getLanguageRoute('splash'));
          //       }else {
          //         Get.toNamed(RouteHelper.getSignInRoute());
          //       }
          //     }
          //   }
          // }
        });
      }
    });
  }
}

import 'package:dhiyodha/data/repository/account_settings_repo.dart';
import 'package:get/get.dart';

class AccountSettingsViewmodel extends GetxController implements GetxService {
  final AccountSettingsRepo accountSettingsRepo;

  AccountSettingsViewmodel({required this.accountSettingsRepo}) {}

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
  }

  RxInt showBioValue = 1.obs;
  RxInt showConnectionValue = 1.obs;
  RxInt showTestimonialValue = 1.obs;
  RxInt showGalleryValue = 1.obs;
  RxInt showEmailValue = 1.obs;
  RxInt showContactValue = 1.obs;
  RxInt showPublicSiteValue = 1.obs;
  RxInt showMarketingEmailsValue = 1.obs;
  RxInt showShareDataValue = 1.obs;

  void setShowBioValue(int value) {
    showBioValue.value = value;
  }

  void setShowConnectionValue(int value) {
    showConnectionValue.value = value;
  }

  void setShowTestimonialValue(int value) {
    showTestimonialValue.value = value;
  }

  void setShowGalleryValue(int value) {
    showGalleryValue.value = value;
  }

  void setShowEmailValue(int value) {
    showEmailValue.value = value;
  }

  void setShowContactValue(int value) {
    showContactValue.value = value;
  }

  void setShowPublicSiteValue(int value) {
    showPublicSiteValue.value = value;
  }

  void setShowMarketingEmailsValue(int value) {
    showMarketingEmailsValue.value = value;
  }

  void setShowShareDataValue(int value) {
    showShareDataValue.value = value;
  }
}

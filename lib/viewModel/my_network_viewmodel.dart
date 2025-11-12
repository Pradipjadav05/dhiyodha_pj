import 'package:dhiyodha/data/repository/my_network_repo.dart';
import 'package:get/get.dart';

class MyNetworkViewModel extends GetxController implements GetxService {
  final MyNetworkRepo myNetworkRepo;

  MyNetworkViewModel({required this.myNetworkRepo}) {}

  RxBool _connectionsTab = true.obs, _testimonialTab = false.obs;

  RxBool get connectionsTab => _connectionsTab;

  set connectionsTab(RxBool value) {
    _connectionsTab = value;
  }

  get testimonialTab => _testimonialTab;

  set testimonialTab(value) {
    _testimonialTab = value;
  }
}

import 'package:dhiyodha/data/api/api_checker.dart';
import 'package:dhiyodha/data/repository/attendance_repo.dart';
import 'package:dhiyodha/model/response_model/attendance_list_response_model.dart';
import 'package:get/get.dart';

class AttendanceViewModel extends GetxController implements GetxService {
  final AttendanceRepo attendanceRepo;

  AttendanceViewModel({required this.attendanceRepo});

  bool _isLoading = false;
  RxInt _page = 0.obs;
  RxInt _size = 10.obs;
  RxInt _totalPages = 0.obs;
  List<AttendanceItem> _attendanceList = [];

  bool _isHistoryLoading = false;
  RxInt _historyPage = 0.obs;
  RxInt _historySize = 10.obs;
  RxInt _historyTotalPages = 0.obs;
  List<AttendanceItem> _attendanceHistoryList = [];

  bool get isLoading => _isLoading;
  RxInt get page => _page;
  RxInt get size => _size;
  RxInt get totalPages => _totalPages;
  List<AttendanceItem> get attendanceList => _attendanceList;

  bool get isHistoryLoading => _isHistoryLoading;
  RxInt get historyPage => _historyPage;
  RxInt get historySize => _historySize;
  RxInt get historyTotalPages => _historyTotalPages;
  List<AttendanceItem> get attendanceHistoryList => _attendanceHistoryList;

  Future<void> initData() async {
    _isLoading = false;
    _page.value = 0;
    _size.value = 10;
    _totalPages.value = 0;
    _attendanceList = [];

    _isHistoryLoading = false;
    _historyPage.value = 0;
    _historySize.value = 10;
    _historyTotalPages.value = 0;
    _attendanceHistoryList = [];
  }

  Future<bool> loadMore() async {
    if (page.value < totalPages.value-1) {
      page.value += 1;
      await getAttendanceList(page.value, size.value);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> loadMoreHistory() async {
    if (historyPage.value < historyTotalPages.value-1) {
      historyPage.value += 1;
      await getAttendanceHistory(historyPage.value, historySize.value);
      return true;
    } else {
      return false;
    }
  }

  Future<void> getAttendanceList(int page, int size) async {
    _isLoading = true;
    update();
    Response response = await attendanceRepo.getAttendanceList(page, size);
    _isLoading = false;
    if (response.statusCode == 200) {
      if (page == 0) {
        _attendanceList = [];
      }
      if (response.body['data'] != null && response.body['data']['data'] != null) {
        response.body['data']['data'].forEach((item) {
          _attendanceList.add(AttendanceItem.fromJson(item));
        });
        int total = response.body['data']['total'] ?? 0;
        _totalPages.value = (total / size).ceil();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getAttendanceHistory(int page, int size) async {
    _isHistoryLoading = true;
    update();
    Response response = await attendanceRepo.getAttendanceHistory(page, size);
    _isHistoryLoading = false;
    if (response.statusCode == 200) {
      if (page == 0) {
        _attendanceHistoryList = [];
      }
      if (response.body['data'] != null && response.body['data']['data'] != null) {
        response.body['data']['data'].forEach((item) {
          _attendanceHistoryList.add(AttendanceItem.fromJson(item));
        });
        int total = response.body['data']['total'] ?? 0;
        _historyTotalPages.value = (total / size).ceil();
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}

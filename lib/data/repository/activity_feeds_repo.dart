import 'package:dhiyodha/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityFeedsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ActivityFeedsRepo({required this.apiClient, required this.sharedPreferences});
}

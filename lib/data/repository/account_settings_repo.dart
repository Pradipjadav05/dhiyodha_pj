import 'package:dhiyodha/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountSettingsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AccountSettingsRepo(
      {required this.apiClient, required this.sharedPreferences});
}

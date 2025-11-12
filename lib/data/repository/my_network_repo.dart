import 'package:dhiyodha/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyNetworkRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MyNetworkRepo({required this.apiClient, required this.sharedPreferences});
}

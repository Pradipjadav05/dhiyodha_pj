import 'package:dhiyodha/data/api/api_client.dart';
import 'package:dhiyodha/model/request_model/add_testimonial_request_model.dart';
import 'package:dhiyodha/utils/resource/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestimonialRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TestimonialRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getMyTestimonial(
      int page, int size, String? sort, String? orderBy, String? search) async {
    Map<String, dynamic> queryParameters = Map<String, dynamic>();
    queryParameters.addAll(<String, dynamic>{
      "page": page,
      "size": size,
      "sort": sort,
      "sortDirection": orderBy,
      "search": search
    });
    return await apiClient.getData(
        '$myTestimonialsUrl?page=$page&size=$size&sort=$sort&sortDirection=$orderBy&search=$search');
  }

  Future<Response> deleteTestimonial(String? testimonialID) async {
    return await apiClient.deleteData('$deleteTestimonialUrl$testimonialID');
  }

  Future<Response> addTestimonial(
      AddTestimonialRequestModel addTestimonialRequestModel) async {
    return await apiClient.postData(
        '$addTestimonialUrl', addTestimonialRequestModel.toJson());
  }
}

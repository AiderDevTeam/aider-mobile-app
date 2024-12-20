

import '../env/environment.dart';
import 'git_it_service_locator.dart';
import 'local_storage_service.dart';
import 'remote_config_service.dart';

class ApiConfig{

  static String get baseURL => Environment.inDevMode? RemoteConfigService.getRemoteData.testBaseUrl : RemoteConfigService.getRemoteData.baseUrl;

  static Future<Map<String, String>> getHttpHeaders() async{
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    String token = await sl.get<LocalStorageService>().getToken();
    if(token.isNotEmpty){
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    return headers;
  }



}


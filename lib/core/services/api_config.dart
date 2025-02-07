import 'package:aider_mobile_app/core/services/remote_config_service.dart';

import 'git_it_service_locator.dart';
import 'local_storage_service.dart';

class ApiConfig {
  static String get baseURL =>
      RemoteConfigService.getRemoteData.configs['env']['baseUrl'] as String;

  static Future<Map<String, String>> getHttpHeaders() async {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };
    String token = await sl.get<LocalStorageService>().getToken();
    if (token.isNotEmpty) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }
    return headers;
  }
}

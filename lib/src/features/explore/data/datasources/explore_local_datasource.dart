import 'package:aider_mobile_app/core/services/local_storage_service.dart';

abstract class ExploreLocalDatasource{
}

class ExploreLocalDatasourceImpl extends ExploreLocalDatasource{

  ExploreLocalDatasourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;
}

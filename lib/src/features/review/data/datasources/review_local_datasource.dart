

import '../../../../../core/services/local_storage_service.dart';
import '../../../../../core/services/logger_service.dart';
import '../../domain/review/review_model.dart';

abstract class ReviewLocalDataSource{
  Future<void> persistReviewHistory(ReviewModel historyModel);
  Future<ReviewModel> retrieveReviewHistory();
}

class ReviewLocalDataSourceImpl extends ReviewLocalDataSource{

  ReviewLocalDataSourceImpl({required this.localStorageService,});

  final LocalStorageService localStorageService;


  @override
  Future<ReviewModel> retrieveReviewHistory() async{
    var data = await localStorageService.read('reviewHistory');
    ZLoggerService.logOnInfo('RETRIEVING REVIEW');
    return ReviewModel.fromJson(data as Map<String, dynamic>);
  }


  @override
  Future<void> persistReviewHistory(ReviewModel historyModel) async{
    await localStorageService.encodeAndWrite('reviewHistory', historyModel.toJson());
    ZLoggerService.logOnInfo('PERSISTED REVIEW HISTORY');
  }

}
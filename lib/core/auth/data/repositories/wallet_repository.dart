import 'package:aider_mobile_app/core/auth/domain/models/wallet/wallet_model.dart';
import 'package:aider_mobile_app/core/errors/failure.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:dartz/dartz.dart';

import '../../../services/crash_service.dart';
import '../datasources/wallet_remote_datasource.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletModel>> createWallet(WalletModel wallet);
  Future<Either<Failure, List<WalletModel>>> getWallets();
  Future<Either<Failure, void>> deleteWallet(String walletId);
  Future<Either<Failure, void>> updateWallet(WalletModel wallet);
  Future<Either<Failure, WalletModel>> getWallet(String walletId);
  Future<Either<Failure, void>> swapDefaultWallet(
      String newDefaultWalletId, String oldDefaultWalletId);
}

class WalletRepositoryImpl extends WalletRepository {
  final WalletRemoteDatasource walletRemoteDatasource;

  WalletRepositoryImpl({required this.walletRemoteDatasource});

  @override
  Future<Either<Failure, WalletModel>> createWallet(WalletModel wallet) async {
    try {
      final existingWallets = await walletRemoteDatasource.getWallets();

      if (existingWallets.isEmpty) {
        wallet = wallet.copyWith(isDefault: true);
      }

      if (existingWallets.isNotEmpty &&
          isWalletExist(existingWallets, wallet.accountNumber ?? '',
              wallet.bankCode ?? '')) {
        return const Left(ServerFailure(message: 'Wallet already exists'));
      }

      final result = await walletRemoteDatasource.createWallet(wallet);
      return right(result);
    } catch (e, s) {
      CrashService.setCrashKey('createWallet', 'Creating wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  bool isWalletExist(
      List<WalletModel> wallets, String accountNumber, String bankCode) {
    return wallets.any((wallet) =>
        wallet.accountNumber == accountNumber && wallet.bankCode == bankCode);
  }

  @override
  Future<Either<Failure, void>> deleteWallet(String walletId) async {
    try {
      final result = await walletRemoteDatasource.deleteWallet(walletId);
      return right(result);
    } catch (e, s) {
      CrashService.setCrashKey('deleteWallet', 'Deleting wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, List<WalletModel>>> getWallets() async {
    try {
      final result = await walletRemoteDatasource.getWallets();
      return right(result);
    } catch (e, s) {
      CrashService.setCrashKey('getWallets', 'Getting wallets');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> updateWallet(WalletModel wallet) async {
    try {
      final result = await walletRemoteDatasource.updateWallet(wallet);
      return right(result);
    } catch (e, s) {
      CrashService.setCrashKey('updateWallet', 'Updating wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, WalletModel>> getWallet(String walletId) async {
    try {
      final result = await walletRemoteDatasource.getWallet(walletId);
      return right(result);
    } catch (e, s) {
      CrashService.setCrashKey('getWallet', 'Getting wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }

  @override
  Future<Either<Failure, void>> swapDefaultWallet(
      String newDefaultWalletId, String oldDefaultWalletId) async {
    try {
      ZLoggerService.logOnDebug(
          'Swapping default wallet $newDefaultWalletId, $oldDefaultWalletId');
      final result = await walletRemoteDatasource.swapDefaultWallet(
          newDefaultWalletId, oldDefaultWalletId);
      return right(result);
    } catch (e, s) {
      ZLoggerService.logOnDebug(
          'Swapping default wallet ${e.toString()}, ${s.toString()}');
      CrashService.setCrashKey('swapDefaultWallet', 'Swapping default wallet');
      return Left(FailureToMessage.returnLeftError(e, s));
    }
  }
}

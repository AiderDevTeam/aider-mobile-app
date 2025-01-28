import 'dart:convert';

import 'package:aider_mobile_app/core/errors/error.dart';
import 'package:aider_mobile_app/core/services/logger_service.dart';
import 'package:aider_mobile_app/core/services/remote_config_service.dart';
import 'package:aider_mobile_app/core/utils/app_dialog_util.dart';
import 'package:aider_mobile_app/src/features/transaction/domain/models/bank/bank_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../src/features/inbox/presentation/widgets/paystack_modal_content.dart';
import '../../src/features/transaction/domain/models/paystack/paystac_account_verification_response.dart';
import '../../src/features/transaction/domain/models/paystack/paystack_banks.dart';
import '../../src/features/transaction/domain/models/paystack/paystack_currency.dart';
import '../../src/features/transaction/domain/models/paystack/paystack_initialized_transaction.dart';
import '../../src/features/transaction/domain/models/paystack/paystack_payment_channel.dart';
import '../../src/features/transaction/domain/models/paystack/paystack_transaction_request.dart';
import '../../src/features/transaction/presentation/providers/transaction_provider.dart';
import '../errors/failure.dart';

class PaymentService {
  static final PaymentService _paymentService = PaymentService._internal();
  factory PaymentService() => _paymentService;
  PaymentService._internal();

  static const baseUrl = 'https://api.paystack.co';

  static Future<PaystackInitializedTraction> initializeTransaction(
      PaystackTransactionRequest request) async {
    try {
      final url = Uri.parse('$baseUrl/transaction/initialize');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${request.secretKey}',
        },
        body: request.toJson(),
      );

      return PaystackInitializedTraction.fromJson(response.body);
    } catch (e) {
      rethrow;
    }
  }

  static Future<BankList> fetchBanks() async {
    final url = Uri.parse('$baseUrl/bank');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw const ServerException(message: 'Failed to fetch banks');
    }

    final banks = PaystackBanks.fromJson(json.decode(response.body));
    return BankList.fromJson(banks.data);
  }

  Future<void> openPayStackForm(
    BuildContext context, {
    required String customerEmail,
    required double amount,
    required String reference,
  }) async {
    final request = PaystackTransactionRequest(
      reference: reference,
      secretKey: RemoteConfigService.getRemoteData.payStackSecretKey,
      email: customerEmail,
      amount: amount * 100,
      currency: PaystackCurrency.ngn,
      channel: [
        PaystackPaymentChannel.mobileMoney,
        PaystackPaymentChannel.card,
        PaystackPaymentChannel.ussd,
        PaystackPaymentChannel.bankTransfer,
        PaystackPaymentChannel.bank,
        PaystackPaymentChannel.qr,
        PaystackPaymentChannel.eft,
      ],
    );

    final initializedTransaction = await initializeTransaction(request);

    if (!context.mounted) return;
    if (!initializedTransaction.status) {
      AppDialogUtil.showWarningAlert(context, initializedTransaction.message);
      return;
    }

    final result = await AppDialogUtil.showScrollableBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) => PayStackModalContent(
        transaction: initializedTransaction,
      ),
    );

    if (result != null) {
      if (!context.mounted) return;
      context
          .read<TransactionProvider>()
          .collectionCallback(context, stan: reference);
    }
  }

  static Future<Either<Failure, PaystackAccountVerificationResponse>>
      verifyAccountNumber(String accountNumber, String bankCode) async {
    try {
      final url = Uri.parse(
          '$baseUrl/bank/resolve?account_number=$accountNumber&bank_code=$bankCode');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer sk_live_039d786dc43325fcd6ea1803467b391146683139',
        },
      );

      if (response.statusCode != 200) {
        ZLoggerService.logOnError(
            'VERIFY ACCOUNT NUMBER ERROR ${response.body}');
        return const Left(
            ServerFailure(message: 'Failed to verify account number'));
      }

      return Right(PaystackAccountVerificationResponse.fromJson(
          json.decode(response.body)));
    } catch (e) {
      ZLoggerService.logOnError('VERIFY ACCOUNT NUMBER ERROR ${e.toString()}');
      return const Left(
          ServerFailure(message: 'Failed to verify account number'));
    }
  }
}

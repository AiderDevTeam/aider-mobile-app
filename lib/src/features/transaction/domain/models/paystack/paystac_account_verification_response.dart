class PaystackAccountVerificationResponse {
  final bool status;
  final String message;
  final PaystackAccountVerificationData data;

  PaystackAccountVerificationResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaystackAccountVerificationResponse.fromJson(
      Map<String, dynamic> json) {
    return PaystackAccountVerificationResponse(
      status: json['status'],
      message: json['message'],
      data: PaystackAccountVerificationData.fromJson(json['data']),
    );
  }
}

class PaystackAccountVerificationData {
  final String accountNumber;
  final String accountName;

  PaystackAccountVerificationData({
    required this.accountNumber,
    required this.accountName,
  });

  factory PaystackAccountVerificationData.fromJson(Map<String, dynamic> json) {
    return PaystackAccountVerificationData(
      accountNumber: json['account_number'],
      accountName: json['account_name'],
    );
  }
}

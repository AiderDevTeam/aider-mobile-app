class PaystackBanks {
  final bool status;
  final String message;
  final List<dynamic> data;

  PaystackBanks({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaystackBanks.fromJson(Map<String, dynamic> json) {
    return PaystackBanks(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }
}

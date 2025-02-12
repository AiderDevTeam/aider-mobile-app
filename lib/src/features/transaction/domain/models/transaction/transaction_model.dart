class TransactionModel {
  final int? id;
  final String? externalId;
  final String? amount;
  final String? accountNumber;
  final String? sortCode;
  final String? type;
  final String? status;
  final String? stan;

  const TransactionModel({
    this.id,
    this.externalId,
    this.amount,
    this.accountNumber,
    this.sortCode,
    this.type,
    this.status,
    this.stan,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      externalId: json['external_id'],
      amount: json['amount'],
      accountNumber: json['account_number'],
      sortCode: json['sort_code'],
      type: json['type'],
      status: json['status'],
      stan: json['stan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'external_id': externalId,
      'amount': amount,
      'account_number': accountNumber,
      'sort_code': sortCode,
      'type': type,
      'status': status,
      'stan': stan,
    };
  }
}

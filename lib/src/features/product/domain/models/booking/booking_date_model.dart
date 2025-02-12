class BookingDateModel {
  final int? id;
  final String? date;

  BookingDateModel({
    this.id,
    this.date,
  });

  factory BookingDateModel.fromJson(Map<String, dynamic> json) {
    return BookingDateModel(
      id: json['id'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
    };
  }
}

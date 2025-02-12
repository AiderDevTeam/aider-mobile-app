class PaginationModel {
  final String? previous;
  final String? next;
  final int? currentPage;
  final int? perPage;
  final int? total;

  PaginationModel({
    this.previous,
    this.next,
    this.currentPage,
    this.perPage,
    this.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      previous: json['previous'],
      next: json['next'],
      currentPage: json['current_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previous': previous,
      'next': next,
      'current_page': currentPage,
      'per_page': perPage,
      'total': total,
    };
  }
}

class ProductPhotoModel {
  final int? id;
  final String? externalId;
  final String? photoUrl;

  ProductPhotoModel({
    this.id,
    this.externalId,
    this.photoUrl,
  });

  factory ProductPhotoModel.fromJson(Map<String, dynamic> json) {
    return ProductPhotoModel(
      id: json['id'],
      externalId: json['externalId'],
      photoUrl: json['photoUrl'] ?? json['photo_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'externalId': externalId,
      'photoUrl': photoUrl,
    };
  }

  ProductPhotoModel copyWith({
    int? id,
    String? externalId,
    String? photoUrl,
  }) {
    return ProductPhotoModel(
      id: id ?? this.id,
      externalId: externalId ?? this.externalId,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num?)?.toInt(),
      uid: json['uid'] as String?,
      userId: json['userId'] as String?,
      externalId: json['externalId'] as String?,
      subCategoryItemId: json['subCategoryItemId'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      status: json['status'] as String?,
      value: json['value'] as num?,
      postedAt: json['postedAt'] as String?,
      prices: (json['prices'] as List<dynamic>?)
          ?.map((e) => ProductPriceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => ProductPhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      shareLink: json['shareLink'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      subCategoryItem: json['subCategoryItem'] == null
          ? null
          : SubCategoryItemModel.fromJson(
              json['subCategoryItem'] as Map<String, dynamic>),
      rating: json['rating'] as num?,
      unavailableBookingDates:
          (json['unavailableBookingDates'] as List<dynamic>?)
              ?.map((e) => BookingDateModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'userId': instance.userId,
      'externalId': instance.externalId,
      'subCategoryItemId': instance.subCategoryItemId,
      'name': instance.name,
      'description': instance.description,
      'quantity': instance.quantity,
      'status': instance.status,
      'value': instance.value,
      'postedAt': instance.postedAt,
      'prices': instance.prices,
      'photos': instance.photos,
      'shareLink': instance.shareLink,
      'address': instance.address,
      'user': instance.user,
      'subCategoryItem': instance.subCategoryItem,
      'rating': instance.rating,
      'unavailableBookingDates': instance.unavailableBookingDates,
      'reviews': instance.reviews,
    };

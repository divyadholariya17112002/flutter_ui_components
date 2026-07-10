import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_meta.freezed.dart';
part 'pagination_meta.g.dart';

/// Shared pagination metadata model.
///
/// Demonstrates the Freezed + JsonSerializable pattern for data models.
/// Feature-specific models should follow this same structure.
@freezed
abstract class PaginationMeta with _$PaginationMeta {
  const factory PaginationMeta({
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'total_pages') required int totalPages,
    @JsonKey(name: 'total_items') required int totalItems,
  }) = _PaginationMeta;

  factory PaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaFromJson(json);
}

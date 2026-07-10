import 'package:flutter_ui_components/core/utils/entity.dart';

/// A single item displayed on the home dashboard.
final class HomeItemEntity extends Entity {
  const HomeItemEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.description,
  });

  final String id;
  final String title;
  final String subtitle;
  final String? imageUrl;
  final String? description;

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, description];
}

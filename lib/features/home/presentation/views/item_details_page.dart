import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';

class ItemDetailsPage extends StatelessWidget {
  const ItemDetailsPage({super.key, required this.item});

  final HomeItemEntity item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppAppBar(title: item.title),
      body: ListView(
        padding: EdgeInsets.all(AppResponsive.spacing(context, AppSpacing.lg)),
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: item.imageUrl != null
                  ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                  : ColoredBox(
                      color: theme.colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.person,
                        size: 72,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
            ),
          ),
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.lg)),
          Text(
            item.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.subtitle,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
          SizedBox(height: AppResponsive.spacing(context, AppSpacing.md)),
          Text(
            item.description ??
                'Detailed information for ${item.title} will appear here.',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

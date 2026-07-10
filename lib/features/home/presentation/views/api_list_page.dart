import 'package:flutter/material.dart';
import 'package:flutter_ui_components/core/provider/provider.dart';
import 'package:flutter_ui_components/core/services/route_paths.dart';
import 'package:flutter_ui_components/core/theme/app_responsive.dart';
import 'package:flutter_ui_components/features/home/domain/entities/home_item_entity.dart';
import 'package:flutter_ui_components/features/home/presentation/viewmodels/home_view_model.dart';
import 'package:flutter_ui_components/shared/widgets/app_widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ApiListPage extends StatefulWidget {
  const ApiListPage({super.key});

  @override
  State<ApiListPage> createState() => _ApiListPageState();
}

class _ApiListPageState extends State<ApiListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadHomeItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(title: 'API List'),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, _) {
          return ViewStateBuilder<List<HomeItemEntity>>(
            state: viewModel.state,
            onRetry: viewModel.loadHomeItems,
            onSuccess: (context, data) => RefreshIndicator(
              onRefresh: () => viewModel.loadHomeItems(forceRefresh: true),
              child: data.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        AppEmptyWidget(
                          message: 'No data found. Pull down to refresh.',
                        ),
                      ],
                    )
                  : ListView.separated(
                      padding: EdgeInsets.all(
                        AppResponsive.spacing(context, AppSpacing.lg),
                      ),
                      itemCount: data.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: item.imageUrl != null
                                  ? NetworkImage(item.imageUrl!)
                                  : null,
                              child: item.imageUrl == null
                                  ? const Icon(Icons.person)
                                  : null,
                            ),
                            title: Text(item.title),
                            subtitle: Text(item.subtitle),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => context.push(
                              RoutePaths.itemDetails(item.id),
                              extra: item,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

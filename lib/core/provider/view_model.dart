import 'package:flutter/foundation.dart';

/// Root contract for all presentation-layer ViewModels.
///
/// Every ViewModel extends [ChangeNotifier] so widgets can listen via
/// [Consumer], [context.watch], or [context.read] from Provider.
abstract class ViewModel extends ChangeNotifier {
  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  /// Override to release subscriptions, controllers, or timers.
  @protected
  void onDispose() {}
}

import 'package:flutter_ui_components/core/utils/result.dart';

/// Contract for single-responsibility use cases (Command pattern).
///
/// Each use case encapsulates one business operation and returns a [Result].
abstract interface class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

/// Marker for use cases that require no input parameters.
class NoParams {
  const NoParams();
}

/// Contract for refreshing an expired access token.
///
/// Wire a real implementation when the backend supports refresh tokens.
/// [PlaceholderTokenRefreshHandler] is registered by default.
abstract interface class TokenRefreshHandler {
  Future<String?> refresh();

  Future<void> onRefreshFailed();
}

/// Placeholder — replace with a real refresh-token API integration.
class PlaceholderTokenRefreshHandler implements TokenRefreshHandler {
  @override
  Future<String?> refresh() async {
    // TODO: Call POST /auth/refresh with stored refresh token.
    return null;
  }

  @override
  Future<void> onRefreshFailed() async {
    // TODO: Clear session and navigate to login.
  }
}

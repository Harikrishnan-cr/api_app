import 'package:collection/collection.dart';

class Auth {
  final String tokenType;
  final int expiresIn;
  String? accessToken;
  String? refreshToken;

  Auth({
    required this.tokenType,
    required this.expiresIn,
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  String toString() {
    return 'Auth(tokenType: $tokenType, expiresIn: $expiresIn, accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        tokenType: json['token_type'] as String,
        expiresIn: json['expires_in'] as int,
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token_type': tokenType,
        'expires_in': expiresIn,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };

  Auth copyWith({
    String? tokenType,
    int? expiresIn,
    String? accessToken,
    String? refreshToken,
  }) {
    return Auth(
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Auth) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      tokenType.hashCode ^
      expiresIn.hashCode ^
      accessToken.hashCode ^
      refreshToken.hashCode;
}

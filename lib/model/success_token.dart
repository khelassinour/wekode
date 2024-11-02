class ApiResponse {
  final bool? success;
  final String? message;
  final String? code;
  final TokenData? data;
  final ApiError? error;
  final dynamic debug;

  ApiResponse({
    this.success,
    this.message,
    this.code,
    this.data,
    this.error,
    this.debug,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json['success'],
      message: json['message'],
      code: json['code'],
      data: json['data'] != null ? TokenData.fromJson(json['data']) : null,
      error: json['error'] != null ? ApiError.fromJson(json['error']) : null,
      debug: json['debug'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'code': code,
      'data': data?.toJson(),
      'error': error?.toJson(),
      'debug': debug,
    };
  }
}

class TokenData {
  final String? accessToken;

  TokenData({
    this.accessToken,
  });

  factory TokenData.fromJson(Map<String, dynamic> json) {
    return TokenData(
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}

class ApiError {
  final String? type;
  final String? description;
  final String? version;

  ApiError({
    this.type,
    this.description,
    this.version,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      type: json['type'],
      description: json['description'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'description': description,
      'version': version,
    };
  }
}

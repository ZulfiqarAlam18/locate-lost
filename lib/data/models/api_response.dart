class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;
  final int? statusCode;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
    this.statusCode,
  });

  factory ApiResponse.success(T data, String message) {
    return ApiResponse(
      success: true,
      message: message,
      data: data,
    );
  }

  factory ApiResponse.error(String error, {int? statusCode}) {
    return ApiResponse(
      success: false,
      message: error,
      error: error,
      statusCode: statusCode,
    );
  }
}
class SignupResponse {
  final bool success;
  final String message;

  SignupResponse({required this.success, required this.message});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? 'Unknown error',
    );
  }
}

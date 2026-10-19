class LoginResponseModel {
  final bool success;
  final String message;
  final String? token;
  final DateTime? expiresAtUtc;
  final LoginUserModel? user;
  final dynamic errors;

  const LoginResponseModel({
    required this.success,
    required this.message,
    this.token,
    this.expiresAtUtc,
    this.user,
    this.errors,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;

    return LoginResponseModel(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
      token: data?['token']?.toString(),
      expiresAtUtc: data?['expiresAtUtc'] != null
          ? DateTime.tryParse(data!['expiresAtUtc'].toString())
          : null,
      user: data?['user'] is Map<String, dynamic>
          ? LoginUserModel.fromJson(
              data!['user'] as Map<String, dynamic>,
            )
          : null,
      errors: json['errors'],
    );
  }
}

class LoginUserModel {
  final int id;
  final String username;
  final String empName;
  final String deptName;
  final int roleId;
  final String roleName;

  const LoginUserModel({
    required this.id,
    required this.username,
    required this.empName,
    required this.deptName,
    required this.roleId,
    required this.roleName,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      username: json['username']?.toString() ?? '',
      empName: json['empName']?.toString() ?? '',
      deptName: json['deptName']?.toString() ?? '',
      roleId: (json['roleId'] as num?)?.toInt() ?? 0,
      roleName: json['roleName']?.toString() ?? '',
    );
  }
}
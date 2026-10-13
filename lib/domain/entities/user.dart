import 'package:equatable/equatable.dart';

/// Pure domain entity representing an authenticated user
class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String? displayName;
  final String? token;

  const User({
    required this.id,
    required this.username,
    required this.email,
    this.displayName,
    this.token,
  });

  @override
  List<Object?> get props => [id, username, email, displayName, token];
}

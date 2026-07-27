class UserEntity {
  const UserEntity({
    required this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.isAnonymous = false,
  });

  final String id;
  final String? name;
  final String? email;
  final String? photoUrl;
  final bool isAnonymous;
}

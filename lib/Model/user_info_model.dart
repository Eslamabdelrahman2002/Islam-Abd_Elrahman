class UserInfo {
  final String biography;
  final String birthday;
  final String? deathday;

  UserInfo({
    required this.biography,
    required this.birthday,
    this.deathday,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      biography: json['biography'],
      birthday: json['birthday'],
      deathday: json['deathday'],
    );
  }
}

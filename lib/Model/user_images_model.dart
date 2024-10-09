class UserImage {
  final String filePath;

  UserImage({required this.filePath});

  factory UserImage.fromJson(Map<String, dynamic> json) {
    return UserImage(
      filePath: json['file_path'],
    );
  }
}

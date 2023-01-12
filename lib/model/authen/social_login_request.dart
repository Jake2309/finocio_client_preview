class SocialLoginRequest {
  String uid, name, deviceKey, socialRefreshToken, email;

  SocialLoginRequest({
    required this.uid,
    required this.name,
    required this.deviceKey,
    required this.socialRefreshToken,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'deviceKey': deviceKey,
        'socialRefreshToken': socialRefreshToken,
        'email': email
      };
}

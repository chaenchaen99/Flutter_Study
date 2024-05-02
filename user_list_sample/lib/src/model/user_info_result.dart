import 'package:equatable/equatable.dart';

class UserInfoResult extends Equatable {
  final int currentPage;
  final List<UserInfo> userInfoList;

  const UserInfoResult({
    required this.currentPage,
    required this.userInfoList,
  });

  factory UserInfoResult.fromJson(Map<String, dynamic> json) {
    return UserInfoResult(
        currentPage: (json['info']['page'] as int) + 1,
        userInfoList: json['results']
            .map<UserInfo>((item) => UserInfo.fromJson(item))
            .toList());
  }

  UserInfoResult copyWithFromJson(Map<String, dynamic> json) {
    return UserInfoResult(
        currentPage: (json['info']['page'] as int) + 1,
        userInfoList: userInfoList
          ..addAll(
            json['results'],
          ));
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

class UserInfo extends Equatable {
  final String profileImage;
  final String name;
  final String email;
  final String phone;

  const UserInfo({
    required this.profileImage,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      profileImage: json['picture']['medium'],
      name: json['name']['first'] + json['name']['last'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}

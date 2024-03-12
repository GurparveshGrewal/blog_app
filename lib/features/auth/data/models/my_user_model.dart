import 'package:blog_app/features/auth/domain/entities/my_user.dart';

class MyUserModel extends MyUser {
  MyUserModel({
    required super.uid,
    required super.name,
    required super.email,
  });

  static final empty = MyUserModel(
    uid: '',
    name: '',
    email: '',
  );

  static MyUserModel fromJSON(Map<String, dynamic> data) {
    return MyUserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
    );
  }
}

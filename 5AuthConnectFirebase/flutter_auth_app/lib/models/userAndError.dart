import 'package:flutter/services.dart';
import 'package:flutter_auth_app/models/user.dart';

class UserAndError {

  final User user;
  final PlatformException error;

  UserAndError({ this.user, this.error });

}
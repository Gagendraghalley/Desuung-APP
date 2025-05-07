import 'package:myapp/config/api_endpoints.dart';

class ApiService {
  static void login() {
    print('Logging in... to ${ApiEndpoints.login}');
  }

  static void register() {
    print('Registering... to ${ApiEndpoints.register}');
  }

  static void resetPassword() {
    print('Resetting password... to ${ApiEndpoints.resetPassword}');
  }

  static void changePassword() {
    print('Changing password... to ${ApiEndpoints.changePassword}');
  }

  static void getProfile() {
    print('Getting profile... to ${ApiEndpoints.getProfile}');
  }

  static void updateProfile() {
    print('Updating profile... to ${ApiEndpoints.updateProfile}');
  }

  static void getAnnouncements() {
    print('Getting announcements... to ${ApiEndpoints.getAnnouncements}');
  }

  static void getNotifications() {
    print('Getting notifications... to ${ApiEndpoints.getNotifications}');
  }
}
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:Yes_Loyalty/core/constants/const.dart';
import 'package:Yes_Loyalty/core/db/shared/shared_prefernce.dart';
import 'package:Yes_Loyalty/core/model/login/login.dart';
import 'package:Yes_Loyalty/core/model/login_validation/login_validation.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static Future<Either<LoginValidation, Login>> login({
    required String email,
    required String password,
    String? fcm_token,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}user/login');

    print("Initial FCM Tokennn Aswathy: $fcm_token");

    // Define form data
    Map<String, String> formData = {
      'email': email,
      'password': password,
      'fcm_token': fcm_token ?? '',
    };

    // Encode the form data
    var response = await http.post(url, body: formData);

    // Check the response status code
    if (response.statusCode == 200) {
      // Decode the response body
      print('Login Api response is: ${response.body}');
      var jsonMap = json.decode(response.body);

      // Construct Login object from parsed data
      var login = Login.fromJson(jsonMap);

      await SetSharedPreferences.storeAccessToken(login.misc.accessToken) ??
          'Access Token empty';

      return right(login);
    } else if (response.statusCode == 500) {
      print('${response.body}');
      var jsonMap = json.decode(response.body);

      var validate = LoginValidation.fromJson(jsonMap);

      return left(validate);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }
}

class DeviceRegistrationService {
  static Future<void> registerNewDevice({
    required String fcmToken,
    required String ipAddress,
    required String platform,
    required String location,
    String? deviceId,
    String? deviceModel,
    String? osVersion,
    String? deviceName,
  }) async {
    log("DeviceRegistrationService =================== JkWorkz");
    final url = Uri.parse('${ApiConstants.baseUrl}user/register-new-device');

    log('Jk ===== fcm: $fcmToken');
    log('Jk ===== ipAddress: $ipAddress');
    log('Jk ===== platform: $platform');
    log('Jk ===== location: $location');
    log('Jk ===== deviceId: $deviceId');
    log('Jk ===== deviceModel: $deviceModel');
    log('Jk ===== osVersion: $osVersion');
    log('Jk ===== fcm: $fcmToken');
    log('Jk ===== deviceName: $deviceName');

    // Define form data
    Map<String, String> formData = {
      'fcm_token': fcmToken,
      'ip_address': ipAddress,
      'platform': platform,
      'location': location,
      'device_id': deviceId ?? '',
      'device_model': deviceModel ?? '',
      'os_version': osVersion ?? '',
      'device_name': deviceName ?? '',
    };

    // Encode the form data
    var response = await http.post(url, body: formData);

    // Check the response status code
    if (response.statusCode == 200) {
      print('Device registered successfully: ${response.body}');
    } else {
      throw Exception('Failed to register the device: ${response.body}');
    }
  }
}

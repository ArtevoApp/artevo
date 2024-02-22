import 'package:artevo/common/models/ip_adress.dart';
import 'package:dio/dio.dart';

abstract class IpAddressService {
  static const baseUrl = "http://ip-api.com/json/?fields=status,city,query";

  static Future<IpAddress?> getIpAddress() async {
    try {
      final response = await Dio().get(baseUrl);

      return IpAddress.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}

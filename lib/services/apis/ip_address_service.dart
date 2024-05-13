import '../../common/models/ip_adress.dart';
import 'package:http/http.dart' as http;

class IpAddressService {
  static const _baseUrl = "http://ip-api.com/json";

  static const _query = "/?fields=country,regionName,city,timezone,query";

  static Future<IpAddress?> get getIpAddress async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + _query));

      return IpAddress.fromJson(response.body);
    } catch (e) {
      return null;
    }
  }
}

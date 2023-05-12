import 'package:get/get.dart';

class GeocodeAPI extends GetConnect {
  static const _url = 'https://geocode.maps.co/reverse';

  Future<Response> getAddress(double latitude, double longitude) {
    return get('$_url?lat=$latitude&lon=$longitude');
  }
}

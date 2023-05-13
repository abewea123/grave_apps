import 'dart:convert';

class GeocodeAddress {
  final String placeId;
  final String license;
  final String osmType;
  final String osmId;
  final String poweredBy;
  final String lat;
  final String lon;
  final String displayName;
  final Address address;
  final List boundingBox;

  GeocodeAddress({
    required this.placeId,
    required this.license,
    required this.poweredBy,
    required this.osmType,
    required this.osmId,
    required this.lat,
    required this.lon,
    required this.displayName,
    required this.address,
    required this.boundingBox,
  });

  factory GeocodeAddress.fromApi(dynamic json) => GeocodeAddress(
        placeId: json['place_id'].toString(),
        license: json['licence'],
        poweredBy: json['powered_by'],
        osmType: json['osm_type'],
        osmId: json['osm_id'].toString(),
        lat: json['lat'].toString(),
        lon: json['lon'].toString(),
        displayName: json['display_name'],
        address: Address.fromJson(
            jsonDecode(jsonDecode(json['address'].toString()))),
        boundingBox: json['boundingbox'],
      );
}

class Address {
  final String neighbourhood;
  final String suburb;
  final String city;
  final String district;
  final String state;
  final String postcode;
  final String country;
  final String countryCode;

  Address({
    required this.neighbourhood,
    required this.suburb,
    required this.city,
    required this.district,
    required this.state,
    required this.postcode,
    required this.country,
    required this.countryCode,
  });

  factory Address.fromJson(dynamic json) => Address(
        neighbourhood: json['neighbourhood'].toString(),
        suburb: json['suburb'].toString(),
        city: json['city'],
        district: json['district'],
        state: json['state'],
        postcode: json['postcode'],
        country: json['country'],
        countryCode: json['country_code'],
      );
}

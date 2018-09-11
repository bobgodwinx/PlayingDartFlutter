import 'dart:async';
import 'dart:convert';

import 'address.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PrefernecesStorage {
  static const _jsonRoot = 'addresses';

  Map _json;

  Future<List<Address>> loadAddressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('address_list') ?? '';

    _json = JsonDecoder().convert(jsonString);

    List<Address> addressList = _json[_jsonRoot]
        .map<Address>((item) => Address.fromJson(item))
        .toList();

    return addressList;
  }

  saveAddresses(Address address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('address_list');

    if (jsonString.isNotEmpty) {
      _json = JsonDecoder().convert(jsonString);
    }
    List<Address> addressList = _json == null
        ? []
        : _json[_jsonRoot]
            .map<Address>((item) => Address.fromJson(item))
            .toList();

    addressList.add(address);

    prefs.setString(
      'address_list',
      JsonEncoder().convert({
        'addresses': addressList.map((address) => address.toJson()).toList(),
      }),
    );

    return true;
  }
}

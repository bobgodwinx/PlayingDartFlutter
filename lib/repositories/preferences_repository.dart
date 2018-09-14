import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../address.dart';
import 'repository.dart';

class PrefernecesStorage implements Repository{
  static const _jsonRoot = 'addresses';

  Map _json;

  Future<List<Address>> loadAddressList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('address_list');
    List<Address> addressList = [];
    if (jsonString != null) {
      _json = JsonDecoder().convert(jsonString);

      addressList = _json[_jsonRoot]
          .map<Address>((item) => Address.fromJson(item))
          .toList();
    }

    return addressList;
  }

  addAddress(Address address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = prefs.getString('address_list');

    List<Address> addressList = [];
    if (jsonString != null) {
      _json = JsonDecoder().convert(jsonString);
    } else {
      _json[_jsonRoot].map<Address>((item) => Address.fromJson(item)).toList();
    }

    addressList.add(address);

    prefs.setString(
      'address_list',
      JsonEncoder().convert({
        'addresses': addressList.map((address) => address.toJson()).toList(),
      }),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'address.dart';

class FileStorage {
  static const _jsonRoot = 'addresses';

  final String fileName;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.fileName,
    this.getDirectory,
  );

  Future<List<Address>> loadAddressList() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final addressList = json[_jsonRoot].map<Address>((item) => Address.fromJson(item)).toList();

    return addressList;
  }

  Future<File> saveAddresses(List<Address> addressList) async {
    final file = await _getLocalFile();
    final String jsonString = JsonEncoder().convert({
      'addresses': addressList.map((address) => address.toJson()).toList(),
    });

    return file.writeAsString(jsonString);
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/$fileName.json');
  }

}

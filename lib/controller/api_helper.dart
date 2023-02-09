import 'dart:convert';

import 'package:venturo_test_app/model/Menu.dart';
import 'package:venturo_test_app/model/Voucher.dart';
import 'package:http/http.dart' as http;

class Api_Helper {
  Future<List<Data>> fetchData() async {
    const url = "https://tes-mobile.landa.id/api/menus";
    try {
      final response = await http.get(Uri.parse(url));
      return (json.decode(response.body)['datas'] as List)
          .map((e) => Data.fromJson(e))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<VoucherData> fetchVoucher(String kode) async {
    final url = 'https://tes-mobile.landa.id/api/vouchers?kode=$kode';
    try {
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body)['status_code'] == 200) {
        return VoucherData.fromJson(json.decode(response.body)['datas']);
      } else if (json.decode(response.body)['status_code'] == 204) {
        return VoucherData(
            id: 0,
            kode: '',
            nominal: 0,
            createdAt: '',
            updatedAt: '');
      } else {
        return VoucherData(
            id: 0,
            kode: '',
            nominal: 0,
            createdAt: '',
            updatedAt: '');
        ;
      }
    } catch (e) {
      rethrow;
    }
  }
}

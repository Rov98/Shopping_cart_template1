import 'package:get/get.dart';
import 'package:venturo_test_app/controller/api_helper.dart';
import 'package:venturo_test_app/model/Menu.dart';
import 'package:venturo_test_app/model/Voucher.dart';

class Item_Controller extends GetxController {
  List<Data> _listItem = [];
  List<VoucherData> _listVoucher = [];

  List<Data> get allItem {
    return [..._listItem];
  }

  List<VoucherData> get allVoucher {
    return [..._listVoucher];
  }

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    final data = await Api_Helper().fetchData();
    _listItem = [...data];
    update();
  }

  Future<void> getVoucher(String kode) async {
    final data = await Api_Helper().fetchVoucher(kode);
    _listVoucher = [data];
    update();
  }
}

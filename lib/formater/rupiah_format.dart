import 'package:intl/intl.dart';

class Rupiah_Format {
  static String convertIDR(dynamic val) {
    var convert = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return convert.format(val);
  }
}

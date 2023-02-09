// To parse this JSON data, do
//
//     final voucher = voucherFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Voucher voucherFromJson(String str) => Voucher.fromJson(json.decode(str));

String voucherToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  Voucher({
    required this.statusCode,
    required this.datas,
  });

  int statusCode;
  List<VoucherData> datas;

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        statusCode: json["status_code"],
        datas: List<VoucherData>.from(
            json["datas"].map((x) => VoucherData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
      };
}

class VoucherData {
  VoucherData({
    required this.id,
    required this.kode,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String kode;
  int nominal;
  String createdAt;
  String updatedAt;

  factory VoucherData.fromJson(Map<String, dynamic> json) => VoucherData(
        id: json["id"],
        kode: json["kode"],
        nominal: json["nominal"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nominal": nominal,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

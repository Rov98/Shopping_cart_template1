// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

class Menu {
    Menu({
        required this.statusCode,
        required this.datas,
    });

    int statusCode;
    List<Data> datas;

    factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        statusCode: json["status_code"],
        datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
    };
}

class Data {
    Data({
        required this.id,
        required this.nama,
        required this.harga,
        required this.tipe,
        required this.gambar,
    });

    int id;
    String nama;
    int harga;
    String tipe;
    String gambar;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nama: json["nama"],
        harga: json["harga"],
        tipe: json["tipe"],
        gambar: json["gambar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "tipe": tipe,
        "gambar": gambar,
    };
}

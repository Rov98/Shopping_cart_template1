import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_test_app/controller/item_controller.dart';

class pilihanVoucherWidget extends StatelessWidget {
  pilihanVoucherWidget({
    super.key,
  });

  var controllerVoucherInput = TextEditingController();
  var find = Get.put(Item_Controller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.discount,
                color: Colors.blue,
              ),
              Text(
                'Voucher',
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
          TextButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.white,
                builder: (context) => Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.discount,
                            color: Colors.blue,
                          ),
                          Text(
                            'Punya Kode Voucher?',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Masukan kode voucher disini',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          controller: controllerVoucherInput,
                          decoration: InputDecoration(
                            hintText: 'Masukan Kode Voucher',
                            suffixIcon: IconButton(
                              onPressed: () {
                                controllerVoucherInput.clear();
                              },
                              icon: const Icon(
                                Icons.cancel,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.find<Item_Controller>().getVoucher(
                                  controllerVoucherInput.value.text);
                              print('berhasil');
                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              backgroundColor: Colors.blue,
                            ),
                            child: const Text(
                              'Validasi Voucher',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
            icon: const Text('Input Voucher'),
            label: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}

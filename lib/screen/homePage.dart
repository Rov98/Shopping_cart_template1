import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/item_controller.dart';
import '../widget/itemCardWidget.dart';
import '../widget/pesanButtonWidget.dart';

import '../widget/pilihanVoucherWidget.dart';
import '../widget/totalPesanan.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  var totalQuantity = 0.obs;
  var totalType = <String>[].obs;
  var isVoucherused = false.obs;
  var discount = 0.obs;
  var isOrder = false.obs;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  pesanButton() {
    widget.isOrder.value = !widget.isOrder.value;
  }

  batalkanButton() {
    Get.defaultDialog(
      title: '',
      content: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          children: const [
            Icon(
              Icons.warning,
              color: Colors.blue,
              size: 45,
            ),
            Flexible(
              child: Text(
                'Apakah Anda ingin membatalkan pesanan',
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      cancel: TextButton(
        style: TextButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(
                color: Colors.black,
              ),
            )),
        onPressed: () {
          Get.back();
        },
        child: const Text('Batal'),
      ),
      confirm: TextButton(
        style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: const BorderSide(
                color: Colors.black,
              ),
            )),
        onPressed: () {},
        child: const Text(
          'Yakin',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
    widget.isOrder.value = !widget.isOrder.value;
  }

  addVoucher(String value) {
    Get.find<Item_Controller>().getVoucher(value).then(
      (value) {
        //add newVoucher to variable
        var newVoucher = Get.find<Item_Controller>().allVoucher.first;
        //check if null
        if (!widget.isVoucherused.value && newVoucher.createdAt.isNotEmpty) {
          //set discount value
          widget.discount.value = newVoucher.nominal;
          //close dialog and used voucher once
          Get.back();
          widget.isVoucherused.value = !widget.isVoucherused.value;
          //-->
        } else if (newVoucher.createdAt.isEmpty) {
          //if null then show dialog
          Get.defaultDialog(
            content: const Text(
              'Voucher not found',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          Get.defaultDialog(
            content: const Text(
              'Already Used Voucher',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }

  void addItem(Item_Controller controller, int index) {
    //add quantity
    var id = controller.allItem[index].id.toString();
    var findIndex =
        widget.totalType.value.indexWhere((element) => element == id);

    widget.totalQuantity.value =
        widget.totalQuantity.value + controller.allItem[index].harga;
    if (findIndex == -1) {
      widget.totalType.value.add(id);
    }
  }

  void removeItem(Item_Controller controller, int index) {
    //decrease quantity if quantity already 0 then can't be decrease
    var id = controller.allItem[index].id.toString();
    var findIndex =
        widget.totalType.value.indexWhere((element) => element == id);

    if (widget.totalQuantity.value <= 0) {
      widget.totalQuantity.value = 0;
    } else {
      widget.totalQuantity.value =
          widget.totalQuantity.value - controller.allItem[index].harga;
    }

    //remove id if quantity is 0 and findIndex
    if (findIndex != -1 && widget.totalQuantity.value <= 0) {
      widget.totalType.value.removeAt(findIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: GetBuilder<Item_Controller>(
                init: Item_Controller(),
                initState: (_) {},
                builder: (controller) => ListView.builder(
                  itemCount: controller.allItem.length,
                  itemBuilder: (context, index) => Obx(
                    () => itemCardWidget(
                      isOrder: widget.isOrder.value,
                      addItem: () => addItem(controller, index),
                      removeItem: () => removeItem(controller, index),
                      title: controller.allItem[index].nama,
                      image: controller.allItem[index].gambar,
                      price: controller.allItem[index].harga.toString(),
                      tipe: controller.allItem[index].tipe,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Obx(
                      () => totalPesananWidget(
                        totalQuantity: widget.totalQuantity.value,
                        totalType: widget.totalType.value.length,
                      ),
                    ),
                    const dividerWidget(),
                    Obx(
                      () => pilihanVoucherWidget(
                        passVoucherData: addVoucher,
                        discount: widget.discount.value,
                      ),
                    ),
                    Obx(
                      () => pesanButtonWidget(
                        price: widget.totalQuantity.value,
                        discount: widget.discount.value,
                        isOrder: widget.isOrder.value,
                        batalkanButton: batalkanButton,
                        pesanButton: pesanButton,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class dividerWidget extends StatelessWidget {
  const dividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      width: double.infinity,
      color: Colors.grey,
    );
  }
}

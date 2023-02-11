import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/item_controller.dart';
import '../widget/itemCardWidget.dart';
import '../widget/cartCardWidget.dart';
import '../widget/pesanButtonWidget.dart';

import '../widget/pilihanVoucherWidget.dart';
import '../widget/totalPesanan.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  var totalQuantity = 0.obs;
  var isVoucherused = false.obs;
  var discount = 0.obs;
  var isOrder = false.obs;
  var itemOrder = {}.obs;

  pesanButton() {
    isOrder.value = !isOrder.value;
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
        onPressed: () {
          isOrder.value = !isOrder.value;
          resetValue();
          Get.back();
        },
        child: const Text(
          'Yakin',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  resetValue() {
    totalQuantity.value = 0;
    isVoucherused.value = false;
    discount.value = 0;
    itemOrder.value.clear();
  }

  addVoucher(String value) {
    Get.find<Item_Controller>().getVoucher(value).then(
      (value) {
        //add newVoucher to variable
        var newVoucher = Get.find<Item_Controller>().allVoucher.first;
        //check if null
        if (!isVoucherused.value && newVoucher.createdAt.isNotEmpty) {
          //set discount value
          discount.value = newVoucher.nominal;
          //close dialog and used voucher once
          Get.back();
          isVoucherused.value = !isVoucherused.value;
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
    totalQuantity.value = totalQuantity.value + controller.allItem[index].harga;
    // itemOrder as a temporary map to use for item in the cart after we press order
    if (itemOrder.containsKey(controller.allItem[index])) {
      // assign value of itemOrder with the key of controller.allItem[index].
      // the key a bit long but it's easy to understand and it's must be a unique keys.
      // not the id of controller.allItem[index].id
      itemOrder[controller.allItem[index]] += 1;
    } else {
      itemOrder[controller.allItem[index]] = 1;
    }
  }

  void removeItem(Item_Controller controller, int index) {
    //decrease quantity if quantity already 0 then can't be decrease
    if (totalQuantity.value <= 0) {
      totalQuantity.value = 0;
    } else {
      totalQuantity.value =
          totalQuantity.value - controller.allItem[index].harga;
    }
    // if contains key data like the previous addItem AND when the value is 1 which is when
    // we remove the key(affect value) where key is equal to the data we want(controller.allItem[index])
    if (itemOrder.containsKey(controller.allItem[index]) &&
        itemOrder[controller.allItem[index]] == 1) {
      itemOrder.removeWhere((key, value) => key == controller.allItem[index]);
    } else if (itemOrder.containsKey(controller.allItem[index]) &&
        itemOrder[controller.allItem[index]] > 0) {
      //if still containsKey but value > 0 we can -1 the value
      itemOrder[controller.allItem[index]] -= 1;
    } else {
      itemOrder;
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
                    () => isOrder.value
                        ? cartCardWidget(
                            title: controller.allItem[index].nama,
                            image: controller.allItem[index].gambar,
                            price: controller.allItem[index].harga.toString(),
                            tipe: controller.allItem[index].tipe,
                            quantity: itemOrder[controller.allItem[index]],
                          )
                        : itemCardWidget(
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
                child: Obx(() => Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        totalPesananWidget(
                          totalQuantity: totalQuantity.value,
                          totalType: itemOrder.keys.length,
                        ),
                        const dividerWidget(),
                        pilihanVoucherWidget(
                          passVoucherData: addVoucher,
                          discount: discount.value,
                        ),
                        pesanButtonWidget(
                          price: totalQuantity.value,
                          discount: discount.value,
                          isOrder: isOrder.value,
                          batalkanButton: batalkanButton,
                          pesanButton: pesanButton,
                        ),
                      ],
                    )),
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

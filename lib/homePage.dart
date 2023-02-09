import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturo_test_app/controller/item_controller.dart';
import 'package:venturo_test_app/constant.dart';
import 'package:venturo_test_app/widget/itemCardWidget.dart';
import 'package:venturo_test_app/widget/pesanButtonWidget.dart';

import 'widget/pilihanVoucherWidget.dart';
import 'widget/totalPesanan.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  var totalQuantity = 0.obs;
  var totalType = <String>[].obs;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  itemBuilder: (context, index) => itemCardWidget(
                    addItem: () {
                      var id = controller.allItem[index].id.toString();
                      widget.totalQuantity.value = widget.totalQuantity.value +
                          controller.allItem[index].harga;
                      var findIndex = widget.totalType.value
                          .indexWhere((element) => element == id);
                      if (findIndex == -1) {
                        widget.totalType.value.add(id);
                      }
                    },
                    removeItem: () {
                      var id = controller.allItem[index].id.toString();
                      if (widget.totalQuantity.value <= 0) {
                        widget.totalQuantity.value = 0;
                      } else {
                        widget.totalQuantity.value =
                            widget.totalQuantity.value -
                                controller.allItem[index].harga;
                      }
                      var findIndex = widget.totalType.value
                          .indexWhere((element) => element == id);
                      if (findIndex != -1) {
                        widget.totalType.value.removeAt(findIndex);
                      }
                    },
                    title: controller.allItem[index].nama,
                    image: controller.allItem[index].gambar,
                    price: controller.allItem[index].harga.toString(),
                    tipe: controller.allItem[index].tipe,
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
                    dividerWidget(),
                    pilihanVoucherWidget(),
                    pesanButtonWidget()
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

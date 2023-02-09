import 'package:flutter/material.dart';
import 'package:get/get.dart';

class quantityWidget extends StatelessWidget {
  quantityWidget({
    super.key,
    required this.addItem,
    required this.removeItem,
    required this.isOrder,
  });
  VoidCallback addItem, removeItem;
  bool isOrder;
  var numOfQuantity = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        !isOrder
            ? SizedBox(
                width: 30,
                height: 30,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                  ),
                  onPressed: () {
                    if (numOfQuantity.value <= 1) {
                      numOfQuantity.value = 0;
                    } else {
                      numOfQuantity.value = numOfQuantity.value - 1;
                    }
                    removeItem();
                  },
                  child: const Icon(Icons.remove, color: Colors.blue),
                ),
              )
            : Container(
                height: 50,
                width: 2,
                color: Colors.grey.shade400,
              ),
        const SizedBox(
          width: 10,
        ),
        Obx(() => Text(
              numOfQuantity.value.toString(),
              style: TextStyle(fontSize: 15, color: Colors.black),
            )),
        const SizedBox(
          width: 10,
        ),
        !isOrder
            ? SizedBox(
                width: 30,
                height: 30,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                  ),
                  onPressed: () {
                    numOfQuantity.value = numOfQuantity.value + 1;
                    addItem();
                  },
                  child: const Icon(Icons.add, color: Colors.blue),
                ),
              )
            : const Padding(
                padding: EdgeInsets.only(left: 20.0),
              ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class quantityWidget extends StatelessWidget {
  quantityWidget({
    super.key,
    required this.addItem,
    required this.removeItem,
  });
  VoidCallback addItem, removeItem;

  var numOfQuantity = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
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
        ),
        const SizedBox(
          width: 10,
        ),
        Obx(
          () => Text(
            numOfQuantity.value.toString(),
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        SizedBox(
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
      ],
    );
  }
}

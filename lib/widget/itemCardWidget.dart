import 'package:flutter/material.dart';

import '../constant.dart';
import 'quantityWidget.dart';

class itemCardWidget extends StatelessWidget {
  itemCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.tipe,
    required this.addItem,
    required this.removeItem,
    required this.isOrder,
  });
  String image, title, price, tipe;
  bool isOrder;
  VoidCallback addItem, removeItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10.0),
      color: mainCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: ClipRRect(
            child: SizedBox.square(
              dimension: 60,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            Text(
              'Rp.$price',
              style: const TextStyle(fontSize: 15, color: Colors.blue),
            ),
          ],
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.note_rounded,
              color: Colors.blue,
            ),
            Text(
              tipe,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            )
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            quantityWidget(
              isOrder: isOrder,
              addItem: addItem,
              removeItem: removeItem,
            ),
          ],
        ),
      ),
    );
  }
}

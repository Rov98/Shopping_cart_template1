import 'package:flutter/material.dart';

import '../constant.dart';
import 'quantityWidget.dart';

class cartCardWidget extends StatelessWidget {
  cartCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.tipe,
    required this.quantity,
  });
  String image, title, price, tipe;
  int? quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10.0),
      color: quantity == null ? Colors.grey : mainCardColor,
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              height: 50,
              width: 2,
              color: Colors.grey.shade400,
            ),
            Text(
              quantity == null ? '0' : quantity.toString(),
              style: const TextStyle(fontSize: 15, color: Colors.black),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

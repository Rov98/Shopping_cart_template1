import 'package:flutter/material.dart';
import './/formater/rupiah_format.dart';

class pesanButtonWidget extends StatelessWidget {
  pesanButtonWidget({
    super.key,
    required this.price,
    required this.discount,
    required this.pesanButton,
    required this.batalkanButton,
    required this.isOrder,
  });
  int price, discount;
  bool isOrder;
  VoidCallback pesanButton, batalkanButton;

  @override
  Widget build(BuildContext context) {
    //create var total for price and discount operation
    int total = price - discount;
    //create condiiton
    total <= 0 ? total = 0 : total;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.shopping_bag,
                color: Colors.blue,
              ),
              Column(
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    Rupiah_Format.convertIDR(total),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  )
                ],
              )
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  )),
              onPressed: !isOrder ? pesanButton : batalkanButton,
              child: Text(
                !isOrder ? 'Pesan Sekarang' : 'Batalkan',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ))
        ],
      ),
    );
  }
}

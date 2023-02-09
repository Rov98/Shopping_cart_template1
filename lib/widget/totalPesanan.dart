import 'package:flutter/material.dart';
import './/formater/rupiah_format.dart';

class totalPesananWidget extends StatelessWidget {
  totalPesananWidget({
    super.key,
    required this.totalQuantity,
    required this.totalType,
  });

  var totalQuantity, totalType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              text: TextSpan(
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  children: [
                const TextSpan(text: 'Total Pesanan '),
                TextSpan(
                  text: '($totalType Menu): ',
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ])),
          Text(
            Rupiah_Format.convertIDR(totalQuantity),
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final String id;
  final String name;
  final String date;

  const ItemWidget({
    super.key,
    required this.id,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                border: Border.all(width: 2),
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                  image: AssetImage('assets/${id}.png'),
                ),
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(date),
        ],
      ),
    );
  }
}

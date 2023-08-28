import 'package:certcons_proyecto/models/toolModel.dart';
import 'package:flutter/material.dart';

class ItemWidget extends StatelessWidget {
  final ToolModel toolModel;

  const ItemWidget({
    super.key,
    required this.toolModel,
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
                  image: AssetImage('assets/${toolModel.id}.png'),
                ),
              ),
            ),
          ),
          Text(
            toolModel.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(toolModel.date),
        ],
      ),
    );
  }
}

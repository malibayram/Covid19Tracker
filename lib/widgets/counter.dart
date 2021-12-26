import 'package:flutter/material.dart';

import '../utilities/constant.dart';

class Counter extends StatelessWidget {
  final int number;
  final Color color;
  final String title;
  const Counter({
    Key? key,
    required this.number,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 30,
            color: kShadowColor,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(.26),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(title, style: kSubTextStyle),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            number != 87235 ? "$number" : "NR",
            style: TextStyle(
              fontSize: 40,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tafweed/constants.dart';

class TrackLine extends StatelessWidget {
  final int point;
  const TrackLine({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for(int i=0; i<4; i++)
        Expanded(
          flex: 2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 1,
                  color: i < point ? mainColor : Colors.grey[300],
                ),
              ),
              CircleAvatar(
                radius: 10,
                backgroundColor: i < point ? mainColor : Colors.grey[300],
                child: const Icon(Icons.check, color: Colors.white, size: 10),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: 1,
            color: 3 < point ? mainColor : Colors.grey[300],
          ),
        ),
      ],
    );
  }
}
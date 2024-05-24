import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ScanItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ScanItem({
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {},
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.blue,
              ),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            Gap(16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            Icon(CupertinoIcons.right_chevron, size: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
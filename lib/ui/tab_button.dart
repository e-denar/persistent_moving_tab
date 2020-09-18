import 'package:flutter/material.dart';

class TabButton extends StatelessWidget {
  const TabButton({
    Key key,
    this.title,
    this.isSelected,
    this.onTap,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Wrap(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          decoration: BoxDecoration(
              color:
                  isSelected ? Color.fromRGBO(230, 230, 230, 1) : Colors.white,
              borderRadius: BorderRadius.circular(40)),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
      child: Wrap(children: [
        Container(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          decoration: BoxDecoration(
              color: Colors.orange, borderRadius: BorderRadius.circular(99)),
          child: Text('Follow',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500)),
        ),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:persistent_moving_tab/ui/follow_button.dart';
import 'package:persistent_moving_tab/ui/subtitle.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({
    this.controller,
  });

  final ScrollController controller;

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Stack(
          children: [
            Align(alignment: Alignment.topRight, child: FollowButton()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Subtitle(
                  text: '@hollymccauley',
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Holly Mccauley',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Subtitle(text: 'Pregnant'),
                    SizedBox(
                      width: 4,
                    ),
                    Subtitle(
                      text: 'due Jul \'20',
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Subtitle(
                      text: '1 boy',
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Subtitle(
                      text: '1 girl',
                    ),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

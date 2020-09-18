import 'package:flutter/material.dart';

import 'follower_info.dart';
import 'profile_description.dart';
import 'user_info.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        Column(
          children: [
            UserInfo(),
            ProfileDescription(),
            FollowerInfo(),
          ],
        ),
      ]),
    );
  }
}

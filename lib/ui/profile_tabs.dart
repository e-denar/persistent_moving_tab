import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_moving_tab/blocs/selection_bloc.dart';
import 'package:persistent_moving_tab/ui/follow_button.dart';
import 'package:persistent_moving_tab/ui/tab_button.dart';

class ProfileTabs extends SliverPersistentHeaderDelegate {
  const ProfileTabs({this.controller, this.isExpanded});

  final SelectionBloc controller;
  final bool isExpanded;

  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return StreamBuilder<int>(
        initialData: 0,
        stream: controller.indexStream,
        builder: (context, index) {
          return Container(
            color: Colors.white.withOpacity(0.3),
            padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabButton(
                  title: 'Posts',
                  isSelected: index.data == 0,
                  onTap: () => controller.index = 0,
                ),
                TabButton(
                  title: 'Collections',
                  isSelected: index.data == 1,
                  onTap: () => controller.index = 1,
                ),
                TabButton(
                  title: 'Memories',
                  isSelected: index.data == 2,
                  onTap: () => controller.index = 2,
                ),
                Spacer(),
                isExpanded ? Container() : FollowButton(),
              ],
            ),
          );
        });
  }

  @override
  bool shouldRebuild(covariant ProfileTabs oldDelegate) {
    return oldDelegate.controller != controller;
  }
}

import 'package:flutter/material.dart';

import 'memories_content.dart';
import 'post_content.dart';

class Content extends StatefulWidget {
  const Content({
    Key key,
    this.index,
  }) : super(key: key);

  final int index;

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  GlobalObjectKey _contentKey;

  @override
  void initState() {
    _contentKey = GlobalObjectKey('Content');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      key: _contentKey,
      index: widget.index,
      children: [
        PostsContent(),
        MemoriesContent(),
        ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
                  key: PageStorageKey<String>('third $index'),
                  title: Text('third $index'),
                )),
      ],
    );
  }
}

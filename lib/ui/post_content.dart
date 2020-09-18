import 'package:flutter/material.dart';

class PostsContent extends StatefulWidget {
  const PostsContent({
    Key key,
  }) : super(key: key);

  @override
  _PostsContentState createState() => _PostsContentState();
}

class _PostsContentState extends State<PostsContent> {
  PageStorageKey pageContentKey;
  @override
  void initState() {
    pageContentKey = PageStorageKey('Posts');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        key: pageContentKey,
        itemCount: 100,
        itemBuilder: (context, index) => ListTile(
              key: PageStorageKey<String>('first $index'),
              title: Text('first $index'),
            ));
  }
}

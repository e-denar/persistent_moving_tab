import 'package:flutter/material.dart';

class MemoriesContent extends StatefulWidget {
  const MemoriesContent({
    Key key,
  }) : super(key: key);

  @override
  _MemoriesContentState createState() => _MemoriesContentState();
}

class _MemoriesContentState extends State<MemoriesContent> {
  PageStorageKey pageContentKey;
  @override
  void initState() {
    // TODO: implement initState
    pageContentKey = PageStorageKey('Memories');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: pageContentKey,
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        key: PageStorageKey<String>('sec $index'),
        title: Text('sec $index'),
      ),
    );
  }
}

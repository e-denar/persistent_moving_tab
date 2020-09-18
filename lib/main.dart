import 'package:flutter/material.dart';
import 'package:persistent_moving_tab/ui/background_image.dart';
import 'package:persistent_moving_tab/ui/profile_tabs.dart';

import 'blocs/selection_bloc.dart';
import 'ui/profile_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  bool isExpanded;
  GlobalObjectKey _contentKey;
  List<Widget> _widgetOptions;

  SelectionBloc bloc;
  @override
  void initState() {
    bloc = SelectionBloc();
    _contentKey = GlobalObjectKey('Content123');
    isExpanded = true;
    final bucket = PageStorageBucket();
    _widgetOptions = <Widget>[
      PageStorage(
        bucket: bucket,
        child: ListView.builder(
          key: PageStorageKey<String>('0'),
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(
            title: Text('List1 $index'),
          ),
        ),
      ),
      PageStorage(
        bucket: bucket,
        child: ListView.builder(
          key: PageStorageKey<String>('1'),
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(
            title: Text('List2 $index'),
          ),
        ),
      ),
      PageStorage(
        bucket: bucket,
        child: ListView.builder(
          key: PageStorageKey<String>('2'),
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(
            title: Text('List3 $index'),
          ),
        ),
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            _buildFirstAppBar(context),
            ProfileInfo(),
            _buildProfileTabs()
          ];
        },
        body: StreamBuilder<int>(
          initialData: 0,
          stream: bloc.indexStream,
          builder: (context, index) => _widgetOptions[index.data],
        ),
      ),
    );
  }

  SliverPersistentHeader _buildProfileTabs() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: ProfileTabs(controller: bloc, isExpanded: isExpanded),
    );
  }

  SliverAppBar _buildFirstAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      pinned: true,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: isExpanded ? Colors.white : Colors.grey,
        ),
        onPressed: () {},
      ),
      title: Text(
        'Holly McCauley',
        textAlign: TextAlign.center,
        style: TextStyle(color: isExpanded ? Colors.transparent : Colors.grey),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: isExpanded ? Colors.white : Colors.grey,
          ),
          onPressed: () {},
        ),
      ],
      expandedHeight: _expandedHeight(context),
      flexibleSpace: Stack(
        children: [
          Positioned(
              child: FlexibleSpaceBar(
                background: BackgroundImage(),
                collapseMode: CollapseMode.none,
              ),
              top: 0,
              left: 0,
              right: 0,
              bottom: 0),
          Positioned(
            child: Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
            ),
            bottom: -1,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  double _expandedHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.4;
}

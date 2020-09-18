import 'package:flutter/material.dart';
import 'package:persistent_moving_tab/ui/background_image.dart';
import 'package:persistent_moving_tab/ui/follow_button.dart';
import 'package:persistent_moving_tab/ui/follower_info.dart';
import 'package:persistent_moving_tab/ui/profile_description.dart';
import 'package:persistent_moving_tab/ui/tab_button.dart';
import 'package:persistent_moving_tab/ui/user_info.dart';

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
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  GlobalKey appBarKey;
  GlobalKey profileFeedKey;
  GlobalKey tabKey;
  bool showAppBar = false;
  bool isExpanded = true;

  bool lastStatus;

  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    _scrollController = ScrollController();
    appBarKey = GlobalKey(debugLabel: 'appBar');
    profileFeedKey = GlobalKey(debugLabel: 'profileFeed');
    tabKey = GlobalKey(debugLabel: 'tabKey');
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
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
              style: TextStyle(
                  color: isExpanded ? Colors.transparent : Colors.grey),
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
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                key: tabKey,
                children: [
                  UserInfo(),
                  ProfileDescription(),
                  FollowerInfo(),
                ],
              ),
            ]),
          ),
          SliverAppBar(
            toolbarHeight: 40,
            backgroundColor: Colors.white,
            bottom: BottomDivider(),
            elevation: 0,
            pinned: true,
            flexibleSpace: Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabButton(
                    title: 'Posts',
                    isSelected: _selectedIndex == 0,
                    onTap: () => setState(() {
                      _selectedIndex = 0;
                    }),
                  ),
                  TabButton(
                    title: 'Collections',
                    isSelected: _selectedIndex == 1,
                    onTap: () => setState(() {
                      _selectedIndex = 1;
                    }),
                  ),
                  TabButton(
                    title: 'Memories',
                    isSelected: _selectedIndex == 2,
                    onTap: () => setState(() {
                      _selectedIndex = 2;
                    }),
                  ),
                  Spacer(),
                  isExpanded ? Container() : FollowButton(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    Content(),
                    ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, index) => ListTile(
                              title: Text('second $index'),
                            )),
                    ListView.builder(
                        itemCount: 100,
                        itemBuilder: (context, index) => ListTile(
                              title: Text('third $index'),
                            )),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  void _scrollListener() {
    RenderBox box = tabKey.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    if ((offset.dy + kToolbarHeight) <= 0) {
      setState(() {
        isExpanded = false;
        lastStatus = isExpanded;
      });
    } else if (((offset.dy + kToolbarHeight) > 0) &&
        (lastStatus == isExpanded)) {
      setState(() {
        isExpanded = true;
        lastStatus = isExpanded;
      });
    }
  }

  double _expandedHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.4;
}

class Content extends StatefulWidget {
  const Content({
    Key key,
  }) : super(key: key);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  ScrollController _scrollController;

  bool isNonScrollable = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 100,
      itemBuilder: (context, index) => ListTile(
        title: Text('first $index'),
      ),
    );
  }
}

class Tabs extends StatefulWidget implements PreferredSizeWidget {
  final isExpanded;

  const Tabs({
    this.isExpanded,
  });
  @override
  _TabsState createState() => _TabsState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: AnimatedOpacity(
        opacity: isOpaque(),
        duration: Duration(milliseconds: 150),
        child: Row(
          children: [
            TabButton(
              title: 'Posts',
              isSelected: true,
            ),
            TabButton(
              title: 'Collections',
              isSelected: false,
            ),
            TabButton(
              title: 'Memories',
              isSelected: false,
            ),
            Spacer(),
            FollowButton(),
          ],
        ),
      ),
    );
  }

  double isOpaque() => widget.isExpanded ? 0 : 1;
}

class BottomDivider extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 1.5,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0.0);
}

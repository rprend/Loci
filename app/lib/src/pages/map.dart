import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loci/src/pages/call.dart';
import 'package:permission_handler/permission_handler.dart';

bool editMode = true;

class MapArguments {
  final bool editable;

  MapArguments(this.editable);
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  BuildingSprite sprite;
  @override
  void initState() {
    super.initState();

    sprite = BuildingSprite();
  }

  @override
  Widget build(BuildContext context) {
    final MapArguments args = ModalRoute.of(context).settings.arguments;
    editMode = args != null ? args.editable : false;

    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
        ),
        backgroundColor: Colors.black,
        body: InteractiveViewer(
            constrained: false,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/IsoMap.jpg'))),
              child: Stack(
                children: [
                  BuildingSprite(x: 500, y: 500),
                  BuildingSprite(
                    x: 550,
                    y: 600,
                    name: 'ECEB',
                  )
                ],
              ),
            )));
  }
}

class BuildingSprite extends StatefulWidget {
  double x;
  double y;
  String spritePath;
  String name;
  String description;
  int capacity;

  BuildingSprite(
      {Key key,
      this.x,
      this.y,
      this.spritePath = 'building.png',
      this.name = 'Siebel Center for Computer Science',
      this.capacity = 8,
      this.description =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'});

  @override
  _BuildingSpriteState createState() => _BuildingSpriteState();
}

class _BuildingSpriteState extends State<BuildingSprite> {
  Sprite sprite;
  bool favorited = false;
  @override
  void initState() {
    super.initState();
    sprite = Sprite(widget.spritePath);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.y,
        left: widget.x,
        child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  barrierColor: Colors.black12,
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder:
                        (BuildContext context, StateSetter setModalState) {
                      return editMode
                          ? buildEditSheet(setModalState)
                          : buildInfoSheet(setModalState);
                    });
                  });
            },
            child: Image.asset('assets/images/${widget.spritePath}')));
  }

  Container buildInfoSheet(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBuildingInfo(),
          Spacer(),
          buildButtonBar(setModalState)
        ],
      ),
    );
  }

  Container buildEditSheet(StateSetter setModalState) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildBuildingInfo(),
          Spacer(),
          buildButtonBar(setModalState)
        ],
      ),
    );
  }

  Widget buildButtonBar(StateSetter setModalState) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  onJoin(widget.name);
                },
                color: Colors.blue,
                child: Text(
                  'Join Room',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  setModalState(() {
                    favorited = !favorited;
                  });
                },
                color: Colors.blue,
                disabledBorderColor: Colors.blue,
                highlightedBorderColor: Colors.blue,
                child: Row(
                  children: [
                    favorited
                        ? Icon(Icons.bookmark, color: Colors.red)
                        : Icon(Icons.bookmark_border, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Bookmark',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlineButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {},
                color: Colors.blue,
                disabledBorderColor: Colors.blue,
                highlightedBorderColor: Colors.blue,
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.blue),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  Widget buildBuildingInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 20),
              ),
              Chip(
                avatar: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                backgroundColor: Colors.white10,
                label: Text(
                  "0/${widget.capacity}",
                ),
              ),
              Text(
                widget.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        Image.asset('assets/images/${widget.spritePath}'),
      ]),
    );
  }

  Future<void> onJoin(String channelName) async {
    if (channelName.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: channelName,
            role: ClientRole.Broadcaster,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}

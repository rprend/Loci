import 'dart:convert';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loci/src/pages/call.dart';
import 'package:permission_handler/permission_handler.dart';

bool editMode = true;
bool checkEditMode = false;
List<String> buildingImagePaths;

class MapArguments with ChangeNotifier {
  bool editable;
  String assetBg = 'assets/images/IsoMap.jpg';
  List<BuildingSprite> sprites = [];

  MapArguments({this.editable, this.assetBg, this.sprites});

  void update(bool val) {
    editable = val;
    notifyListeners();
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<BuildingSprite> sprites;
  AssetImage map;

  @override
  void initState() {
    super.initState();

    checkEditMode = false;
    _getBuildingAsset();

    sprites = [
      BuildingSprite(x: 500, y: 500),
      BuildingSprite(
        x: 550,
        y: 600,
        name: 'ECEB',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (!checkEditMode) {
      final MapArguments args = ModalRoute.of(context).settings.arguments;
      if (args != null) {
        editMode = args != null ? args.editable : false;
        sprites = args.sprites;
        map = AssetImage(args.assetBg);
      }

      checkEditMode = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: editMode ? Text('Edit map') : Text('Explore'),
          actions: [
            editMode
                ? IconButton(
                    icon: Icon(Icons.done),
                    onPressed: () {
                      setState(() {
                        editMode = false;
                      });
                    },
                  )
                : Container()
          ],
        ),
        floatingActionButton: editMode
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    sprites.add(BuildingSprite(x: 500, y: 500));
                  });
                },
                child: Icon(Icons.add),
              )
            : Container(),
        backgroundColor: Colors.black,
        body: InteractiveViewer(
            constrained: false,
            child: Container(
              height: 1000,
              width: 1000,
              decoration: BoxDecoration(image: DecorationImage(image: map)),
              child: Stack(
                children: sprites,
              ),
            )));
  }

  Future _getBuildingAsset() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        .where((String key) => key.contains('assets/buildings'))
        .where((String key) => key.contains('.png'))
        .toList();

    print(imagePaths);

    buildingImagePaths = imagePaths;
  }
}

class BuildingSprite extends StatefulWidget {
  double x;
  double y;
  String spritePath;
  String name;
  String description;
  double capacity;

  BuildingSprite({
    Key key,
    this.x,
    this.y,
    this.spritePath = 'assets/images/building.png',
    this.name = 'Siebel Center for Computer Science',
    this.capacity = 8,
    this.description = 'Edit this description to something more useful!',
  });

  @override
  _BuildingSpriteState createState() => _BuildingSpriteState();
}

class _BuildingSpriteState extends State<BuildingSprite> {
  bool favorited = false;
  double _capacity = 8;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: widget.y,
        left: widget.x,
        child: GestureDetector(
          onPanUpdate: (details) {
            if (editMode) {
              setState(() {
                widget.x += details.delta.dx;
                widget.y += details.delta.dy;
              });
            }
          },
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
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
          child: Image.asset(widget.spritePath),
        ));
  }

  Container buildInfoSheet(StateSetter setModalState) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildBuildingInfo(),
          ),
          Spacer(),
          buildButtonBar(setModalState)
        ],
      ),
    );
  }

  Widget buildEditSheet(StateSetter setModalState) {
    return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Spacer(),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Saved ${widget.name}'),
                        duration: Duration(milliseconds: 500),
                      ));

                      Navigator.pop(context);
                    },
                    color: Colors.deepPurple,
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            hintText: widget.name,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 5, right: 15),
                          ),
                          initialValue: widget.name,
                          maxLines: 2,
                          onChanged: (value) {
                            setState(() {
                              widget.name = value;
                            });
                          },
                        ),
                        Row(
                          children: [
                            SizedBox(width: 16),
                            Text(
                              'Max capacity:',
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        Slider(
                          value: _capacity,
                          min: 2,
                          max: 12,
                          divisions: 10,
                          activeColor: Colors.deepPurple,
                          inactiveColor: Colors.deepPurple,
                          label: _capacity.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _capacity = value;
                            });
                          },
                        ),
                        Row(
                          children: [
                            SizedBox(width: 16),
                            Text(
                              'Description:',
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            hintText: 'description',
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 5, right: 15),
                          ),
                          maxLines: 8,
                          initialValue: widget.description,
                          onChanged: (value) {
                            setState(() {
                              widget.description = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Image.asset('assets/images/${widget.spritePath}'),
                ]),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: buildingImagePaths.length,
                  onPageChanged: (int index) {
                    setState(() {
                      widget.spritePath = buildingImagePaths[index];
                    });
                  },
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return Image.asset(buildingImagePaths[itemIndex]);
                  },
                ),
              ),
            ],
          ),
        ));
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
                color: Colors.deepPurple,
                child: Row(
                  children: [
                    Icon(Icons.videocam, color: Colors.white),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Join Room',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
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
                color: Colors.deepPurple,
                disabledBorderColor: Colors.deepPurple,
                highlightedBorderColor: Colors.deepPurple,
                child: Row(
                  children: [
                    favorited
                        ? Icon(Icons.bookmark, color: Colors.red)
                        : Icon(Icons.bookmark_border, color: Colors.deepPurple),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Bookmark',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
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
                color: Colors.deepPurple,
                disabledBorderColor: Colors.deepPurple,
                highlightedBorderColor: Colors.deepPurple,
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.deepPurple),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Share',
                      style: TextStyle(fontSize: 16, color: Colors.deepPurple),
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
                  color: Colors.deepPurple,
                ),
                backgroundColor: Colors.white10,
                label: Text(
                  "0/${widget.capacity.toStringAsFixed(0)} joined",
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
        Image.asset(widget.spritePath),
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

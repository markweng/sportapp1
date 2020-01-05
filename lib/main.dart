import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sport_score_app/add_rccord/add_record_page.dart';
import 'package:sport_score_app/launch/launch_screen.dart';
import 'package:sport_score_app/settings/settings_page.dart';
import 'package:sport_score_app/utils/screen_util.dart';
import 'package:sport_score_app/widgets/edit_pi_info.dart';
import 'package:sport_score_app/widgets/sel_item_btn.dart';
import 'home/home_page.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({
    Key key,
  }) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
 
  List<Widget> pages = [HomePage(), SettingsPage()];
  int _showIndex = 0;
  bool showApp = false;
 @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), (){
      setState(() {
        showApp = true;
      });
    });
  }
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return showApp
        ? Scaffold(
            backgroundColor: Colors.white,
            drawerScrimColor: Colors.white,
            body: IndexedStack(
              index: _showIndex,
              children: pages,
            ),
            bottomNavigationBar: BottomAppBar(
                color: Colors.yellow,
                shape: const CircularNotchedRectangle(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        MdiIcons.scoreboardOutline,
                        color: _showIndex == 0
                            ? Color(0xFF004747)
                            : Colors.grey[300],
                        size: 30,
                      ),
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          this._showIndex = 0;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: _showIndex == 1
                            ? Color(0xFF004747)
                            : Colors.grey[300],
                        size: 30,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          this._showIndex = 1;
                        });
                      },
                    ),
                  ],
                )),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white.withAlpha(0),
                  context: context,
                  builder: (BuildContext context) {
                    return new Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 200.0,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            '单打还是双打?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              MaterialButton(
                                color: Colors.limeAccent,
                                child: Row(
                                  children: <Widget>[
                                    Icon(MdiIcons.numeric1Circle),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('单打')
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _editTeamInfo(true);
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              MaterialButton(
                                color: Colors.limeAccent,
                                child: Row(
                                  children: <Widget>[
                                    Icon(MdiIcons.numeric2Circle),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('双打')
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _editTeamInfo(false);
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ).then((val) {
                  print(val);
                });
              },
              backgroundColor: Colors.white,
              tooltip: '添加记录',
              child: Icon(
                MdiIcons.tennisBall,
                size: 55,
                color: Colors.lime[400],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          )
        : LaunchScreen();
  }

  _editTeamInfo(bool isSingle) {
    showModalBottomSheet(
      backgroundColor: Colors.white.withAlpha(0),
      context: context,
      builder: (BuildContext context) {
        return EditPIInfo(
          isSingle: isSingle,
        );
      },
    ).then((val) {
      print(val);
    });
  }
}
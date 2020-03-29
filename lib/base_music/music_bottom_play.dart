import 'package:flutter/material.dart';
import 'package:flutter_music/common/music_store.dart';
import 'package:flutter_music/common/screen_adapter.dart';
import 'dart:math' as math;

class MusicBottomPlay extends StatefulWidget {

  @override
  _MusicBottomPlayState createState() => _MusicBottomPlayState();
}

class _MusicBottomPlayState extends State<MusicBottomPlay> with TickerProviderStateMixin{
  AnimationController  _animationController;
  var imageUrl = "https://pic.xiami.net/xiamiWeb/10cd9f6b79e0fb457f22380ee90c71c9/f3ff3553dd4f44e511b660ce5e144717-336x335.gif?x-oss-process=image/quality,q_80";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 25),vsync: this);

    _animationController.addStatusListener((state){
      if(state == AnimationStatus.completed){
        _animationController.reset();
        _animationController.forward();
      }

    });

    _animationController.forward();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MusicStore.Theme.of(context).theme,
        border: Border(top: BorderSide(color: Colors.white,width: 0.5))
      ),
      padding: EdgeInsets.only(top: 5,bottom: 5),
      margin: EdgeInsets.only(bottom: 40),
      width: double.infinity,
      height: ScreenAdapter.setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _playInfo(),
          ),
          _pause(),
          _muiscList(),
        ],
      ),
    );
  }

  Widget _muiscList() {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.queue_music,
          size: ScreenAdapter.setHeight(60),
          color: MusicStore.Theme.of(context).titleColor),
    );
  }

  Widget _pause() {
    return Padding(
      padding: EdgeInsets.only(right: 10, left: 10),
      child: Icon(Icons.play_circle_outline,
          size: ScreenAdapter.setHeight(60),
          color: MusicStore.Theme.of(context).titleColor),
    );
  }

  Widget _playInfo() {
    return MusicGestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(
            RouterPageName.MusicPlayMeidaPage,
            arguments: {"heroTagName":"play_bottom_music_hero",
              "title":"少年",
              "subtTitle":"猛然",
              "coverImageUrl":imageUrl
            }
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 20),

        child: Row(
          children: <Widget>[
            RotationTransition(
                alignment: Alignment.center,
                turns: _animationController,
                child: _clipOval()
            ),
            Expanded(
              flex: 1,
              child: _title(),
            )
          ],
        ),
      ),
    );
  }

  Widget _clipOval(){
    return ClipOval(
        child: CachedNetworkImage(
          imageUrl: "$imageUrl",
          fit: BoxFit.cover,
          placeholder: (context,url){
            return Icon(Icons.music_note,size: ScreenAdapter.setWidth(70),color:MusicStore.Theme.of(context).shadowColor);
          },
        )

    );

  }
  Widget _title(){
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text("少年-猛然",style: TextStyle(color: MusicStore.Theme.of(context).titleColor),),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

}
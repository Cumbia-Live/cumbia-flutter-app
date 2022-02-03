import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:cumbialive/components/components.dart';
import 'package:cumbialive/config/config.dart';
import 'package:cumbialive/functions/functions.dart';
import 'package:cumbialive/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cumbialive/config/constants/agora_constants.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StreamerPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;

  final liveId;

  /// Creates a call page with given channel name.
  const StreamerPage({Key key, this.channelName, this.role, this.liveId})
      : super(key: key);

  @override
  _StreamerPageState createState() => _StreamerPageState();
}

class _StreamerPageState extends State<StreamerPage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  RtcEngine _engine;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  List<Live> liveList = [];

  List<String> audienceList = [];

  List<Message> messagesList = [];

  int audience = 0;

  bool logout = false;

  String message = "";

  final TextEditingController textFieldController = TextEditingController();

  @override
  void initState() {
    _getLive();
    _getMessages();
    _getAudience();
    super.initState();

    /// initialize agora sdk
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Palette.bgColor,
        body: SafeArea(
          child: Center(
            child: Stack(
              children: <Widget>[
                _viewRows(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.height,
                      // decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //         colors: [
                      //       Palette.black.withOpacity(0.8),
                      //       Colors.transparent
                      //     ],
                      //         stops: [
                      //       0.1,
                      //       0.8
                      //     ],
                      //         begin: FractionalOffset.bottomCenter,
                      //         end: FractionalOffset.topCenter)),
                    ),
                  ],
                ),
                !logout ? _toolbar() : const SizedBox.shrink(),
                logout ? _logoutContainer() : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initialize() async {
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width:1920, height:1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(null, widget.channelName, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
    _engine = await RtcEngine.create(appID);
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role);
  }

  /// Add agora event handlers
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
        audience = _users.length;
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<StatefulWidget> list = [];
    if (widget.role == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid)));
    return list;
  }

  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Container(
            child: Column(
          children: <Widget>[_videoView(views[0])],
        ));
      case 2:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow([views[0]]),
            _expandedVideoRow([views[1]])
          ],
        ));
      case 3:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 3))
          ],
        ));
      case 4:
        return Container(
            child: Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Palette.cumbiaLight,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    "EN VIVO",
                    style: Styles.labelLive,
                  ),
                ),
              ),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Palette.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.people,
                      color: Palette.white,
                      size: 12,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "$audience",
                      style: Styles.usersLive,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: Container()),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              reverse: true,
              itemBuilder: (context, position) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: messagesList[position].profilePictureURL !=
                                        '' &&
                                    messagesList[position].profilePictureURL !=
                                        null
                                ? Image.network(
                                    messagesList[position].profilePictureURL,
                                  )
                                : Image.asset('images/liveImage.png'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: "${messagesList[position].username}",
                                  style: Styles.liveStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Palette.white.withOpacity(0.5)),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: messagesList[position].userId ==
                                                user.id
                                            ? ' (en vivo)'
                                            : "",
                                        style: Styles.liveStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Palette.cumbiaLight)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${messagesList[position].message}",
                                style: Styles.liveStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Palette.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: messagesList.length,
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    height: 38,
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Palette.white.withOpacity(0.15),
                    ),
                    child: TextFormField(
                      controller: textFieldController,
                      autofocus: false,
                      style: Styles.btn,
                      keyboardAppearance: Brightness.dark,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: "Escribe un comentario...",
                        hintStyle: Styles.placeholderLiveLbl,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.transparent)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.transparent)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.transparent)),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Palette.transparent)),
                      ),
                      onChanged: (text) {
                        setState(() {
                          message = text;
                        });
                      },
                      onEditingComplete: () {
                        textFieldController.clear();
                        _addMessage();
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      textFieldController.clear();
                      _addMessage();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Palette.white.withOpacity(0.15),
                      ),
                      height: 38,
                      width: 38,
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Palette.white,
                          size: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Container(
                width: MediaQuery.of(context).size.width - 28,
                height: 40,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _onToggleMute,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Palette.white.withOpacity(0.15),
                          ),
                          height: 38,
                          child: Center(
                            child: Icon(
                              muted ? Icons.mic_off : Icons.mic,
                              color: Palette.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            logout = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Palette.white.withOpacity(0.15),
                          ),
                          height: 38,
                          child: Center(
                            child: Icon(
                              Icons.call_end,
                              color: Palette.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: _onSwitchCamera,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Palette.white.withOpacity(0.15),
                          ),
                          height: 38,
                          child: Center(
                            child: Icon(
                              Icons.flip_camera_ios,
                              color: Palette.white,
                              size: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _logoutContainer() {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              logout = false;
            });
          },
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Palette.black.withOpacity(0.75),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: Palette.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CupertinoButton(
                          onPressed: () {
                            setState(() {
                              logout = false;
                            });
                          },
                          minSize: 10,
                          padding: EdgeInsets.zero,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Palette.white.withOpacity(0.5),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                size: 10,
                                color: Palette.black.withOpacity(0.7),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(
                      "¿Cerrar livestream?",
                      style: Styles.tittleLive,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.people,
                          color: Palette.white.withOpacity(0.75),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text("Los usuarios se desconectarán.",
                              style: Styles.labelLivestream),
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.officeBuilding,
                          color: Palette.white.withOpacity(0.75),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                              "Los usuarios podrán visitar tu tienda para seguir comprando.",
                              style: Styles.labelLivestream),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CumbiaButton(
                      onPressed: _updateLive,
                      canPush: true,
                      backgroundColor: Palette.cumbiaLight,
                      title: "Cerrar livestream",
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  Future<void> _getLive() async {
    LogMessage.get("ON LIVE");
    References.lives
        .where("onLive", isEqualTo: true)
        .where("broadcasterId", isEqualTo: user.id)
        .snapshots()
        .listen((querySnapshot) {
      liveList.clear();
      LogMessage.getSuccess("ON LIVE");

      if (querySnapshot.docs.isNotEmpty) {
        // Sí hay documentos
        querySnapshot.docs.forEach((liveDoc) {
          setState(() {
            liveList.add(
              Live(
                  id: liveDoc.id,
                  onLive: liveDoc.data()["onLive"],
                  categoryLive:
                      LiveCategory(name: liveDoc.data()["category"]["name"]),
                  labelLive: liveDoc.data()["labelLive"],
                  startDate: liveDoc.data()["dates"]["startDate"]),
            );
            setState(() {
              audience = _users.length;
            });
          });
        });
      }
    }).onError((e) {
      LogMessage.getError("ON LIVE", e);
    });
  }

  void _updateLive() {
    Map<String, dynamic> liveMap = {
      "onLive": false,
      "dates": {
        "startDate": liveList[0].startDate,
        "endDate": DateTime.now().millisecondsSinceEpoch,
      }
    };
    print("⏳ ACTUALIZARÉ LIVE");
    References.lives
        .doc(widget.liveId)
        .update(liveMap)
        .then((r) async {
      print("✔ LIVE ACTUALIZADO");
      Navigator.pop(context);
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR LIVE: $e");
    });
  }

  void _addMessage() {
    Map<String, dynamic> messageMap = ({
      "created": DateTime.now().millisecondsSinceEpoch,
      "message": message,
      "userId": user.id,
      "username": user.username,
      "profilePictureURL": user.profilePictureURL ??
          "https://firebasestorage.googleapis.com/v0/b/cumbia-live.appspot.com/o/thumbnails%2FliveImage.png?alt=media&token=d9c84a2f-92e8-4f4f-9f79-17b82c992016",
    });
    LogMessage.post("MESSAGE");
    References.lives
        .doc(widget.liveId)
        .collection("messages")
        .add(messageMap)
        .then((r) async {
      LogMessage.postSuccess("MESSAGE");
      setState(() {
        message = "";
      });
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      LogMessage.postError("MESSAGE", e);
    });
  }

  void _getMessages() {
    LogMessage.get("MESSAGES");
    References.lives
        .doc(widget.liveId)
        .collection("messages")
        .orderBy("created", descending: true)
        .snapshots()
        .listen((querySnapshot) {
      LogMessage.getSuccess("MESSAGES");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          messagesList.clear();
          querySnapshot.docs.forEach((messageDoc) {
            messagesList.add(Message(
                userId: messageDoc.data()["userId"],
                username: messageDoc.data()["username"],
                profilePictureURL: messageDoc.data()["profilePictureURL"],
                message: messageDoc.data()["message"],
                created: messageDoc.data()["created"]));
          });
        }
        setState(() {
          // isLoadingCategoriesLayout = false;
        });
      });
    }).onError((e) {
      LogMessage.getError("MESSAGES", e);
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    });
  }

  void _getAudience() {
    LogMessage.get("AUDIENCE");
    References.lives
        .doc(widget.liveId)
        .collection("audience")
        .snapshots()
        .listen((querySnapshot) {
      LogMessage.getSuccess("AUDIENCE");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          audienceList.clear();
          querySnapshot.docs.forEach((audienceDoc) {
            audienceList.add(
              audienceDoc.data()["userId"],
            );
          });
        }
        setState(() {
          audience = audienceList.length;
        });
      });
    }).onError((e) {
      LogMessage.getError("AUDIENCE", e);
      setState(() {
        // isLoadingCategoriesLayout = false;
      });
    });
  }
}

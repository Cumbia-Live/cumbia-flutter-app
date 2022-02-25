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
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'widgets/container_text.dart';
import 'widgets/live_button.dart';

class AudiencePage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String channelName;

  /// non-modifiable client role of the page
  final ClientRole role;

  final Live live;

  /// Creates a call page with given channel name.
  const AudiencePage({Key key, this.channelName, this.role, this.live})
      : super(key: key);

  @override
  _AudiencePageState createState() => _AudiencePageState();
}

const _shrink = SizedBox.shrink();

class _AudiencePageState extends State<AudiencePage> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  RtcEngine _engine;
  List<String> audienceList = [];
  List<Live> liveAudience = [];
  List<Message> messagesList = [];
  List<Product> productsList = [];

  List<Product> carrito = [];
  List<Product> checkoutList = [];
  List<String> addresses = [];
  List<Address> auxList = [];
  List<Address> addressesList = [];
  String message = "";
  bool onLive = true;
  int audience = 0;
  bool isBuying = false;
  bool checkoutButtonBool = false;
  bool isCheckout = false;
  bool isCheckoutDetails = false;
  bool isLoading = false;
  String selectedItem = '';
  String country = '';
  String city = '';
  String purchaseId = '';
  Address putAddress;
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    _users.clear();
    _engine.leaveChannel();
    _engine.destroy();
    super.dispose();
  }

  final TextEditingController textFieldController = TextEditingController();

  void setLiveState() {}

  @override
  void initState() {
    super.initState();
    _getLiveAudience();
    _getMessages();
    _getAudience();
    _getProducts();
    setState(() {
      // country = user.addresses[0].list ?? "";
      // city = user.addresses[0].email ?? "";
      // putAddress = user.addresses[0] ?? "";
      // selectedItem = user.addresses[0].accountHolder;
      //if(user.addresses !=  null) {
      print(user.addresses.length);
        for (int i = 0; i < user.addresses.length; i++) {
          addressesList.add(user.addresses[i]);
        }
     // }
    });
    // _addAddresses();
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
          child: CatapultaScrollView(
            child: !onLive
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "El en vivo ha finalizado",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        CumbiaButton(
                          backgroundColor: Palette.cumbiaLight,
                          onPressed: () {
                            Navigator.pop(context);
                            _removeLiveAudience();
                            dispose();
                          },
                          title: "Ir al home",
                          canPush: true,
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      _viewRows(),
                      Container(
                        width: MediaQuery.of(context).size.width,
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
                      _toolbar()
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
    configuration.dimensions = VideoDimensions(width:1920, height: 1080);
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
      });
    }, userOffline: (uid, elapsed) {
      setState(() {
        onLive = false;
        _finishLive();
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
      padding: isCheckout
          ? const EdgeInsets.fromLTRB(0, 24, 0, 0)
          : const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: isCheckout
          ? _checkoutScreen()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                !isBuying
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CupertinoButton(
                            onPressed: () {
                              _onCallEnd(context);
                            },
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Palette.white.withOpacity(0.15),
                              ),
                              height: 38,
                              width: 38,
                              child: Center(
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Palette.white,
                                  size: 34.0,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 28,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                          CupertinoButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Palette.white.withOpacity(0.15),
                              ),
                              height: 38,
                              width: 38,
                              child: Center(
                                child: Icon(
                                  MdiIcons.store,
                                  color: Palette.white,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : _shrink,
                CatapultaSpace(),
                !isBuying
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.35,
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
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 22,
                                            width: 22,
                                            color: Palette.darkGrey,
                                          ),
                                          Container(
                                            height: 22,
                                            width: 22,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                            ),
                                            child: messagesList[position]
                                                            .profilePictureURL !=
                                                        '' &&
                                                    messagesList[position]
                                                            .profilePictureURL !=
                                                        null
                                                ? Image.network(
                                                    messagesList[position]
                                                        .profilePictureURL,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.asset(
                                                    'images/liveImage.png'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          RichText(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            text: TextSpan(
                                              text:
                                                  "${messagesList[position].username}",
                                              style: Styles.liveStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Palette.white
                                                      .withOpacity(0.5)),
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: messagesList[position]
                                                                .userId ==
                                                            widget.live.streamer
                                                                .id
                                                        ? ' (en vivo)'
                                                        : "",
                                                    style: Styles.liveStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Palette
                                                            .cumbiaLight)),
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
                      )
                    : _shrink,
                !isBuying
                    ? Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 80,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                height: 38,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Palette.white.withOpacity(0.15),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          108,
                                      child: TextFormField(
                                        controller: textFieldController,
                                        autofocus: false,
                                        style: Styles.btn,
                                        keyboardAppearance: Brightness.dark,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        autocorrect: true,
                                        textAlign: TextAlign.start,
                                        decoration: InputDecoration(
                                          hintText: "Escribe un comentario...",
                                          hintStyle: Styles.placeholderLiveLbl,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.transparent,
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.transparent,
                                            ),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.transparent,
                                            ),
                                          ),
                                          disabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.transparent,
                                            ),
                                          ),
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
                                  ],
                                ),
                              ),
                              const SizedBox(width: 4),
                              CupertinoButton(
                                onPressed: () {
                                  textFieldController.clear();
                                  _addMessage();
                                },
                                padding: EdgeInsets.zero,
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
                          const SizedBox(height: 10),
                        ],
                      )
                    : _shrink,
                isBuying ? _productsList() : _shrink,
                productsList.length == 0
                    ? _shrink
                    : Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  setState(() {
                                    isBuying = true;
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 65,
                                      color: Palette.darkGrey,
                                    ),
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Image.network(
                                        productsList[position].imageUrl,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: productsList.length,
                        ),
                      )
              ],
            ),
    );
  }

  /// Lista de prodcutos para comprar cuando los hay
  Widget _productsList() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CupertinoButton(
              onPressed: () {},
              minSize: 10,
              padding: EdgeInsets.zero,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.shopping_cart,
                        size: 18,
                        color: Palette.white,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: Palette.cumbiaLight,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${carrito.length ?? 0}',
                            style: TextStyle(
                              color: Palette.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                setState(() {
                  isBuying = false;
                  checkoutButtonBool = false;
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
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 0.8 + 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, position) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Palette.darkModeBGColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      productsList[position].productName,
                      style: TextStyle(
                        color: Palette.liveGrey,
                        fontSize: 14,
                      ),
                    ),
                    variantLabel(position) == ''
                        ? _shrink
                        : Text(
                            variantLabel(position),
                            style: TextStyle(
                              color: Palette.cumbiaGrey,
                              fontSize: 10,
                            ),
                          ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8 - 40,
                      height: MediaQuery.of(context).size.width * 0.8 - 40,
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Palette.grey,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${productsList[position].imageUrl}',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.4 - 20,
                              height: 105,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    'Precio',
                                    style: TextStyle(
                                      color: Palette.cumbiaGrey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${productsList[position].emeralds}',
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Palette.bgColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset(
                                        'images/emerald.png',
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  if (productsList[position].isSelected) {
                                    carrito.remove(productsList[position]);
                                    productsList[position].isSelected = false;
                                    _checkoutButton();
                                  } else {
                                    carrito.add(productsList[position]);
                                    productsList[position].isSelected = true;
                                    _checkoutButton();
                                  }
                                });
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                width: MediaQuery.of(context).size.width * 0.4 -
                                    20,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Palette.cumbiaDark,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Agregar al carro',
                                      style: TextStyle(
                                        color: Palette.bgColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      productsList[position].isSelected
                                          ? Icons.check
                                          : Icons.shopping_cart,
                                      size: 15,
                                      color: Palette.bgColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                setState(() {
                                  if (productsList[position].isCheckout) {
                                    productsList[position].isCheckout = false;
                                    _checkoutButton();
                                    checkoutList.remove(productsList[position]);
                                  } else {
                                    productsList[position].isCheckout = true;
                                    _checkoutButton();
                                    checkoutList.add(productsList[position]);
                                  }
                                });
                              },
                              padding: EdgeInsets.zero,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 0),
                                width: MediaQuery.of(context).size.width * 0.4 -
                                    20,
                                height: 53,
                                decoration: BoxDecoration(
                                  color: Palette.cumbiaLight,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Agregar a\nCompra Express',
                                      style: TextStyle(
                                        color: Palette.bgColor,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        productsList[position].isCheckout
                                            ? Icon(
                                                Icons.check,
                                                size: 20,
                                                color: Palette.bgColor,
                                              )
                                            : _shrink,
                                        !productsList[position].isCheckout
                                            ? Icon(
                                                Icons.shopping_cart,
                                                size: 15,
                                                color: Palette.bgColor,
                                              )
                                            : _shrink,
                                        !productsList[position].isCheckout
                                            ? Icon(
                                                Icons.arrow_forward,
                                                size: 15,
                                                color: Palette.bgColor,
                                              )
                                            : _shrink
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            itemCount: productsList.length,
          ),
        ),
        checkoutButtonBool
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CumbiaButton(
                  onPressed: () {
                    setState(() {
                      isCheckout = true;
                    });
                  },
                  title: 'Ir a Compra Express',
                  canPush: true,
                ),
              )
            : _shrink,
      ],
    );
  }

  /// Compras checkout
  Widget _checkoutScreen() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CupertinoButton(
                  onPressed: () {
                    setState(() {
                      isCheckout = false;
                      isCheckoutDetails = false;
                      checkoutButtonBool = false;
                      setDefaultCheckout();
                      checkoutList.clear();
                    });
                  },
                  minSize: 10,
                  padding: EdgeInsets.zero,
                  child: Container(
                    height: 23,
                    width: 23,
                    margin: const EdgeInsets.fromLTRB(0, 0, 25, 10),
                    decoration: BoxDecoration(
                        color: Palette.black.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 14,
                        color: Palette.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Palette.black.withOpacity(0.4),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: isCheckoutDetails
                  ? checkoutDetails()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 40, 16, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Carrito',
                            style: TextStyle(
                                color: Palette.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                                MediaQuery.of(context).size.height * 0.75 - 231,
                            child: ListView.builder(
                              itemBuilder: (context, position) {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            Palette.cumbiaDark.withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                              color: Palette.grey,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  checkoutList[position]
                                                      .imageUrl,
                                                ),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${checkoutList[position].productName}',
                                                style: TextStyle(
                                                  color: Palette.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                '${checkoutLabel(position)}',
                                                style: TextStyle(
                                                  color: Palette.white,
                                                  fontSize: 12,
                                                ),
                                              )
                                            ],
                                          ),
                                          CatapultaSpace(),
                                          Stack(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: Palette.black
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 100,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: Palette.black
                                                            .withOpacity(0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: CupertinoButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (checkoutList[
                                                                        position]
                                                                    .unitsCheckout <
                                                                2) {
                                                              showMainActionAlert(
                                                                context,
                                                                'Quitar producto',
                                                                '¿Estás seguro que deseas eliminar el producto del carrito?',
                                                                () {
                                                                  setState(() {
                                                                    checkoutList
                                                                        .remove(
                                                                      checkoutList[
                                                                          position],
                                                                    );
                                                                    if (checkoutList
                                                                            .length ==
                                                                        0) {
                                                                      isCheckout =
                                                                          false;
                                                                    }
                                                                  });
                                                                },
                                                                isDestructiveAction:
                                                                    true,
                                                                mainActionText:
                                                                    'Eliminar',
                                                              );
                                                            } else {
                                                              checkoutList[
                                                                      position]
                                                                  .unitsCheckout--;
                                                            }
                                                            if (checkoutList
                                                                    .length ==
                                                                0) {
                                                              isCheckout =
                                                                  false;
                                                            }
                                                            setDefaultCheckout();
                                                          });
                                                        },
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            color:
                                                                Palette.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      '${checkoutList[position].unitsCheckout}',
                                                      style: TextStyle(
                                                        color: Palette.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: checkoutList[
                                                                        position]
                                                                    .avaliableUnits ==
                                                                checkoutList[
                                                                        position]
                                                                    .unitsCheckout
                                                            ? Palette.darkGrey
                                                            : Palette.black
                                                                .withOpacity(
                                                                    0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: CupertinoButton(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        onPressed: () {
                                                          setState(() {
                                                            if (checkoutList[
                                                                        position]
                                                                    .avaliableUnits >
                                                                checkoutList[
                                                                        position]
                                                                    .unitsCheckout) {
                                                              checkoutList[
                                                                      position]
                                                                  .unitsCheckout++;
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            color:
                                                                Palette.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Palette.darkModeBGColor
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Precio',
                                            style: TextStyle(
                                              color: Palette.white,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${checkoutList[position].emeralds}',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Palette.bgColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Image.asset(
                                                'images/emerald.png',
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                );
                              },
                              itemCount: checkoutList.length,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 161,
              decoration: BoxDecoration(
                color: user.emeralds != null && user.emeralds < checkoutProducts()
                    ? Palette.cumbiaRed
                    : Palette.cumbiaDark,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Saldo disponible',
                        style: TextStyle(
                          fontSize: 14,
                          color: user.emeralds  != null && user.emeralds < checkoutProducts()
                              ? Palette.cumbiaRed
                              : Palette.cumbiaGrey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${user.emeralds}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Palette.bgColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.asset(
                            'images/emerald.png',
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                            fontSize: 16,
                            color: Palette.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${checkoutProducts()}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Palette.bgColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            Image.asset(
                              'images/emerald.png',
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  LiveButton(
                    onPressed: () async {
                      if (isCheckoutDetails) {
                        setState(() {
                          isLoading = true;
                        });
                        await _addPurchase();
                      } else if (user.emeralds!= null && user.emeralds < checkoutProducts()) {
                        _updateEmeraldsUser();
                      } else {
                        setState(() {
                          showMainActionAlert(
                            context,
                            'Compra Express',
                            'Los productos en el carrito serán adquiridos y enviados a su domicilio de inmediato.',
                            () {
                              setState(() {
                                isCheckoutDetails = true;
                              });
                            },
                            mainActionText: 'Comprar',
                          );
                        });
                      }
                    },
                    isLoading: isLoading,
                    canPush: user.emeralds!= null && user.emeralds < checkoutProducts() ? false : true,
                    title: user.emeralds!= null &&user.emeralds < checkoutProducts()
                        ? 'Recargar esmeraldas'
                        : isCheckoutDetails
                            ? 'Comprar ahora'
                            : 'Express Checkout',
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget checkoutDetails() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 150),
      child: ListView(
        children: [
          Text(
            'Información para envío',
            style: TextStyle(
              fontSize: 20,
              color: Palette.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ContainerText(
            title: 'País',
            label: country,
          ),
          ContainerText(
            title: 'Ciudad',
            label: city,
          ),
          Text(
            'Dirección',
            style: TextStyle(
              color: Palette.b8Grey,
              fontSize: 14,
            ),
          ),
          Container(
            height: 36,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                hint: Text(
                  selectedItem,
                  style: Styles.txtTextLbl(),
                ),
                elevation: 30,
                isExpanded: true,
                isDense: true,
                underline: const SizedBox.shrink(),
                items: addresses.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      child: Text(
                        value,
                        style: Styles.txtTextLbl(),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    selectedItem = value;
                  });
                  _setAddress();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Text(
              'Detalles (opcional)',
              style: TextStyle(
                color: Palette.b8Grey,
                fontSize: 14,
              ),
            ),
          ),
          CumbiaTextField(
            controller: descriptionController,
            maxlines: 5,
            onChanged: (value) {
              //_canPush();
            },
            validator: (value) {
              if (value.isNotEmpty) {
                return null;
              } else {
                return 'Por favor, rellena este campo';
              }
            },
            textInputFormatters: [
              LengthLimitingTextInputFormatter(150),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  /// ::::::::::::: BACK ::::::::::::: ///

  Future<void> _getLiveAudience() async {
    LogMessage.get("ON LIVE AUDIENCE");
    References.lives
        .where("onLive", isEqualTo: true)
        .where("userId", isEqualTo: widget.live.streamer.id)
        .snapshots()
        .listen((querySnapshot) {
      liveAudience.clear();
      LogMessage.getSuccess("ON LIVE AUDIENCE");
      if (querySnapshot.docs.isNotEmpty) {
        // Sí hay documentos
        querySnapshot.docs.forEach((liveDoc) {
          setState(() {
            liveAudience.add(
              Live(
                id: liveDoc.id,
                onLive: liveDoc.data()["onLive"],
                categoryLive: LiveCategory(
                  name: liveDoc.data()["category"]["name"],
                ),
                labelLive: liveDoc.data()["labelLive"],
              ),
            );
          });
        });
        setState(() {
          onLive = liveAudience[0].onLive;
        });
        _addLiveAudience();
      }
    }).onError((e) {
      LogMessage.getError("ON LIVE AUDIENCE", e);
    });
  }

  void _addLiveAudience() {
    Map<String, dynamic> liveMap = ({
      "userId": user.id,
    });
    print("⏳ ACTUALIZARÉ LIVE");
    References.lives
        .doc(widget.live.id)
        .collection("audience")
        .add(liveMap)
        .then((r) async {
      print("✔ LIVE ACTUALIZADO");
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR LIVE: $e");
    });
  }

  void _finishLive() {
    Map<String, dynamic> liveMap = ({
      "dates": {
        "startDate": liveAudience[0].startDate,
        "endDate": DateTime.now().millisecondsSinceEpoch,
      },
      "onLive": false
    });
    print("⏳ ACTUALIZARÉ LIVE");
    References.lives
        .doc(widget.live.id)
        .update(liveMap)
        .then((r) async {
      print("✔ LIVE ACTUALIZADO");
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR LIVE: $e");
    });
  }

  Future<void> _removeLiveAudience() async {
    print("⏳ ACTUALIZARÉ LIVE");
    References.lives
        .doc(widget.live.id)
        .collection("audience")
        .where("userId", isEqualTo: user.id)
        .get()
        .then((liveDoc) {
      liveDoc.docs.forEach((audienceDoc) {
        References.lives
            .doc(widget.live.id)
            .collection("audience")
            .doc(audienceDoc.id)
            .delete()
            .then((value) {
          print("✔ LIVE ACTUALIZADO");
        }).catchError((e) {
          showBasicAlert(
            context,
            "Hubo un error.",
            "Por favor, intenta más tarde.",
          );
          print("💩️ ERROR AL ACTUALIZAR LIVE: $e");
        });
      });
    });
  }

  void _addMessage() {
    if (message != '' && message != null) {
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
          .doc(widget.live.id)
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
  }

  void _getMessages() {
    LogMessage.get("MESSAGES");
    References.lives
        .doc(widget.live.id)
        .collection("messages")
        .orderBy("created", descending: true)
        .snapshots()
        .listen((querySnapshot) {
      LogMessage.getSuccess("MESSAGES");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          messagesList.clear();
          querySnapshot.docs.forEach((messageDoc) {
            messagesList.add(
              Message(
                userId: messageDoc.data()["userId"],
                username: messageDoc.data()["username"],
                profilePictureURL: messageDoc.data()["profilePictureURL"],
                message: messageDoc.data()["message"],
                created: messageDoc.data()["created"],
              ),
            );
          });
        }
      });
    }).onError((e) {
      LogMessage.getError("MESSAGES", e);
    });
  }

  void _getProducts() {
    LogMessage.get("PRODUCTS");
    References.lives
        .doc(widget.live.id)
        .collection("productsLive")
        .where('avaliableUnits', isGreaterThan: 0)
        .snapshots()
        .listen((querySnapshot) {
      LogMessage.getSuccess("PRODUCTS");
      setState(() {
        if (querySnapshot.docs.isNotEmpty) {
          querySnapshot.docs.forEach((product) {
            setState(() {
              productsList.add(
                Product(
                  id: product.id,
                  idProduct: product.data()['idProduct'],
                  uid: product.data()['uid'],
                  mainProductId: product.data()['productInfo']['mainProductId'],
                  imageUrl: product.data()['productInfo']['imageUrl'],
                  productName: product.data()['productInfo']['productName'],
                  description: product.data()['productInfo']['description'],
                  reference: product.data()['productInfo']['reference'],
                  isVariant: product.data()['productInfo']['isVariant'],
                  height: product.data()['especifications']['height'],
                  large: product.data()['especifications']['large'],
                  width: product.data()['especifications']['width'],
                  weight: product.data()['especifications']['weight'],
                  color: product.data()['variantInfo']['color'],
                  dimension: product.data()['variantInfo']['dimension'],
                  size: product.data()['variantInfo']['size'],
                  material: product.data()['variantInfo']['material'],
                  style: product.data()['variantInfo']['style'],
                  avaliableUnits: product.data()['avaliableUnits'],
                  price: product.data()['price'],
                  isSelected: product.data()['isSelected'],
                  comission: product.data()['comission'],
                  emeralds: product.data()['emeralds'],
                  unitsCarrito: product.data()['unitsCarrito'],
                  unitsCheckout: product.data()['unitsCheckout'],
                ),
              );
            });
          });
        }
      });
    }).onError((e) {
      LogMessage.getError("PRODUCTS", e);
    });
  }

  void _getAudience() {
    LogMessage.get("AUDIENCE");
    References.lives
        .doc(widget.live.id)
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
    });
  }

  void _updateEmeraldsUser() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> userMap = {'esmeraldas': checkoutProducts()};
    print("⏳ ACTUALIZARÉ USER");
    References.users.doc(user.id).update(userMap).then((r) async {
      print("✔ USER ACTUALIZADO");
      setState(() {
        isLoading = false;
        user.emeralds = checkoutProducts();
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR USER: $e");
    });
  }

  void _updateEmeraldsAfterBuy() {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> userMap = {
      'esmeraldas': user.emeralds - checkoutProducts()
    };
    print("⏳ ACTUALIZARÉ USER");
    References.users.doc(user.id).update(userMap).then((r) async {
      print("✔ USER ACTUALIZADO");
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      print("💩️ ERROR AL ACTUALIZAR USER: $e");
    });
  }

  void _updateProducts() {
    for (int i = 0; i < checkoutList.length; i++) {
      Map<String, dynamic> productMap = {
        'avaliableUnits':
            checkoutList[i].avaliableUnits - checkoutList[i].unitsCheckout,
      };
      print("⏳ ACTUALIZARÉ PRODUCT");
      References.products
          .doc(checkoutList[i].idProduct)
          .update(productMap)
          .then((r) async {
        print("✔ PRODUCT ACTUALIZADO");
        productsList.clear();
        checkoutList.clear();
        _getProducts();
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });

        print("💩️ ERROR AL ACTUALIZAR PRODUCT: $e");
      });
    }
  }

  void _updateProductsLive() {
    for (int i = 0; i < checkoutList.length; i++) {
      Map<String, dynamic> productMap = {
        'avaliableUnits':
            checkoutList[i].avaliableUnits - checkoutList[i].unitsCheckout,
      };
      print("⏳ ACTUALIZARÉ PRODUCT");
      References.lives
          .doc(widget.live.id)
          .collection('productsLive')
          .doc(checkoutList[i].id)
          .update(productMap)
          .then((r) async {
        print("✔ PRODUCT ACTUALIZADO");
        checkoutList.clear();
        productsList.clear();
      }).catchError((e) {
        setState(() {
          isLoading = false;
        });

        print("💩️ ERROR AL ACTUALIZAR PRODUCT: $e");
      });
    }
  }

  // ignore: missing_return
  Future<void> _addPurchase() {
    Map<String, dynamic> purchaseMap = ({
      "uuidStreamer": widget.live.streamer.id,
      "uuidBuyer": widget.live.streamer.id,
      "address": {
        "address": putAddress.address,
        "city": putAddress.city,
        "country": putAddress.country,
      },
      "details": descriptionController.text.trim() ?? '',
      "datePurchase": DateTime.now().millisecondsSinceEpoch,
      "dateReceived": 0,
      "received": false,
      "rated": false,
      "failed": false,
      "rate": 0,
      "emeralds": checkoutProducts(),
    });
    LogMessage.post("PURCHASE");
    References.purchases.add(purchaseMap).then((r) async {
      LogMessage.postSuccess("PURCHASE");
      setState(() {
        purchaseId = r.id;
      });
      _putProducts();
    }).catchError((e) {
      showBasicAlert(
        context,
        "Hubo un error.",
        "Por favor, intenta más tarde.",
      );
      LogMessage.postError("PURCHASE", e);
    });
  }

  Future<void> _putProducts() async {
    Map<String, dynamic> productDoc(int position) {
      // Creo doc a subir
      var productDoc = <String, dynamic>{
        'uid': user.id,
        'productInfo': {
          'mainProductId': checkoutList[position].mainProductId ?? '',
          'imageUrl': checkoutList[position].imageUrl ?? '',
          'productName': checkoutList[position].productName,
          'description': checkoutList[position].description,
          'reference': checkoutList[position].reference,
          'isVariant': checkoutList[position].isVariant,
          'isReceived': false
        },
        'especifications': {
          'height': checkoutList[position].height,
          'large': checkoutList[position].large,
          'width': checkoutList[position].width,
          'weight': checkoutList[position].weight,
        },
        'variantInfo': {
          'color': checkoutList[position].color,
          'dimension': checkoutList[position].dimension,
          'size': checkoutList[position].size,
          'material': checkoutList[position].material,
          'style': checkoutList[position].style,
        },
        'avaliableUnits': checkoutList[position].avaliableUnits,
        'price': checkoutList[position].price,
        'comission': checkoutList[position].comission,
        'emeralds': checkoutList[position].emeralds,
        'isSelected': false,
        'unitsCarrito': 0,
        'unitsCheckout': checkoutList[position].unitsCheckout,
      };
      return productDoc;
    }

    for (var i = 0; i < checkoutList.length; i++) {
      // Subo doc

      LogMessage.post('PRODUCTS');
      await References.purchases
          .doc(purchaseId)
          .collection('products')
          .add(productDoc(i))
          .then((r) {
        LogMessage.postSuccess('PRODUCTS');
      }).catchError((e) {
        LogMessage.postError('PRODUCTS', e);
        setState(() {
          isLoading = false;
        });
        showBasicAlert(
          context,
          'Hubo un error',
          'No pudimos enviar el feedback, por favor intenta más tarde.',
        );
      });
    }
    _updateEmeraldsAfterBuy();
    _updateProducts();
    _updateProductsLive();
    setState(() {
      user.emeralds = user.emeralds - checkoutProducts();

      isCheckout = false;
      isCheckoutDetails = false;
      isBuying = false;
      checkoutButtonBool = false;
      setDefaultCheckout();
      checkoutList.clear();
      descriptionController.text = '';
      isLoading = false;
    });
    showBasicAlert(context, 'Éxito', 'Compra exitosa');
  }

  /// ::::::::::::: FUNCTIONS ::::::::::::: ///

  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
    _removeLiveAudience();
    dispose();
  }

  // ignore: missing_return
  bool _checkoutButton() {
    setState(() {
      for (int i = 0; i < productsList.length; i++) {
        if (productsList[i].isCheckout) {
          checkoutButtonBool = true;
          return true;
        }
      }
      checkoutButtonBool = false;
      return false;
    });
  }

  String variantLabel(int position) {
    // ignore: lines_longer_than_80_chars
    return '${productsList[position].color.isNotEmpty ? '${productsList[position].color}/' : ''}${productsList[position].dimension.isNotEmpty ? '${productsList[position].dimension}/' : ''}${productsList[position].size.isNotEmpty ? '${productsList[position].size}/' : ''}${productsList[position].material.isNotEmpty ? '${productsList[position].material}/' : ''}${productsList[position].style.isNotEmpty ? '${productsList[position].style}/' : ''}';
  }

  String checkoutLabel(int position) {
    // ignore: lines_longer_than_80_chars
    return '${checkoutList[position].color.isNotEmpty ? '${checkoutList[position].color}/' : ''}${checkoutList[position].dimension.isNotEmpty ? '${checkoutList[position].dimension}/' : ''}${checkoutList[position].size.isNotEmpty ? '${checkoutList[position].size}/' : ''}${checkoutList[position].material.isNotEmpty ? '${checkoutList[position].material}/' : ''}${checkoutList[position].style.isNotEmpty ? '${checkoutList[position].style}/' : ''}';
  }

  int checkoutProducts() {
    int emeralds = 0;
    for (int i = 0; i < checkoutList.length; i++) {
      setState(() {
        emeralds += (checkoutList[i].emeralds) * checkoutList[i].unitsCheckout;
      });
    }
    return emeralds;
  }

  void setDefaultCheckout() {
    for (int i = 0; i < productsList.length; i++) {
      setState(() {
        productsList[i].isCheckout = false;
      });
    }
  }

  void _addAddresses() {
    for (int i = 0; i < user.addresses.length; i++) {
      addresses.add(user.addresses[i]);
    }
  }

  void _setAddress() {
    setState(() {
      auxList = addressesList
          .where((element) => element.address == selectedItem)
          .toList();
      country = auxList[0].country;
      city = auxList[0].city;
      putAddress = auxList[0];
    });
  }
}

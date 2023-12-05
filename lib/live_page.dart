import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_to_me/core/models/user_model.dart';
import 'package:talk_to_me/features/home/data/models/room_model.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'constants.dart';
import 'features/home/presentation/view_models/room_cubit/room_cubit.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LivePage extends StatefulWidget {
  final bool isHost;
  final LayoutMode layoutMode;
  final UserModel user;
  final RoomModel room;

  const LivePage({
    Key? key,
    this.layoutMode = LayoutMode.defaultLayout,
    this.isHost = false,
    required this.user,
    required this.room,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {
  final liveController = ZegoLiveAudioRoomController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ZegoUIKitPrebuiltLiveAudioRoom(
            appID: int.parse(dotenv.env['APP_ID']!),
            appSign: dotenv.env['APP_SIGN']!,
            userID: widget.user.id,
            userName: widget.user.username,
            roomID: widget.room.id,
            controller: liveController,
            config: (widget.isHost
                ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host()
                : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience()
              ..onLeaveConfirmation = (context) async {
                BlocProvider.of<RoomCubit>(context)
                    .removeParticipant(roomId: widget.room.id);
                BlocProvider.of<RoomCubit>(context).updateRoom(
                    roomId: widget.room.id,
                    body: {'lastLog': DateTime.now().toIso8601String()});
                return true;
              })
              ..takeSeatIndexWhenJoining =
                  widget.isHost ? getHostSeatIndex() : -1
              ..hostSeatIndexes = getLockSeatIndex()
              ..layoutConfig = getLayoutConfig()
              ..seatConfig = getSeatConfig()
              ..background = background()
              ..foreground = foreground(constraints)
              ..topMenuBarConfig.buttons = [
                ZegoMenuBarButtonName.minimizingButton
              ]
              ..userAvatarUrl = widget.user.image
              ..onUserCountOrPropertyChanged = (List<ZegoUIKitUser> users) {
                debugPrint(
                    'onUserCountOrPropertyChanged:${users.map((e) => e.toString())}');
              }
              ..onSeatClosed = () {
                debugPrint('on seat closed');
              }
              ..onSeatsOpened = () {
                debugPrint('on seat opened');
              }
              ..onSeatsChanged = (
                Map<int, ZegoUIKitUser> takenSeats,
                List<int> untakenSeats,
              ) {
                debugPrint(
                    'on seats changed, taken seats:$takenSeats, untaken seats:$untakenSeats');
              }
              ..onSeatTakingRequested = (ZegoUIKitUser audience) {
                debugPrint('on seat taking requested, audience:$audience');
              }
              ..onSeatTakingRequestCanceled = (ZegoUIKitUser audience) {
                debugPrint(
                    'on seat taking request canceled, audience:$audience');
              }
              ..onInviteAudienceToTakeSeatFailed = () {
                debugPrint('on invite audience to take seat failed');
              }
              ..onSeatTakingInviteRejected = () {
                debugPrint('on seat taking invite rejected');
              }
              ..onSeatTakingRequestFailed = () {
                debugPrint('on seat taking request failed');
              }
              ..onSeatTakingRequestRejected = () {
                debugPrint('on seat taking request rejected');
              }
              ..onHostSeatTakingInviteSent = () {
                debugPrint('on host seat taking invite sent');
              }
              ..onMemberListMoreButtonPressed = onMemberListMoreButtonPressed,
          );
        },
      ),
    );
  }

  Widget foreground(BoxConstraints constraints) {
    return Container();
  }

  Widget background() {
    return Stack(
      children: [
        Positioned(
            top: 10,
            left: 10,
            child: Text(
              widget.room.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xff1B1B1B),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )),
        Positioned(
          top: 10 + 20,
          left: 10,
          child: Text(
            '${widget.room.language} | ${widget.room.languageLevel}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xff606060),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }

  ZegoLiveAudioRoomSeatConfig getSeatConfig() {
    if (widget.layoutMode == LayoutMode.hostTopCenter) {
      return ZegoLiveAudioRoomSeatConfig(
        backgroundBuilder: (
          BuildContext context,
          Size size,
          ZegoUIKitUser? user,
          Map<String, dynamic> extraInfo,
        ) {
          return Container(color: Colors.grey);
        },
      );
    }
    return ZegoLiveAudioRoomSeatConfig();
  }

  int getHostSeatIndex() {
    if (widget.layoutMode == LayoutMode.hostCenter) {
      return 4;
    }

    return 0;
  }

  List<int> getLockSeatIndex() {
    if (widget.layoutMode == LayoutMode.hostCenter) {
      return [4];
    }

    return [0];
  }

  ZegoLiveAudioRoomLayoutConfig getLayoutConfig() {
    final config = ZegoLiveAudioRoomLayoutConfig();
    switch (widget.layoutMode) {
      case LayoutMode.defaultLayout:
        break;
      case LayoutMode.full:
        config.rowSpacing = 5;
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
      case LayoutMode.hostTopCenter:
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 1,
            alignment: ZegoLiveAudioRoomLayoutAlignment.center,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 2,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceEvenly,
          ),
        ];
        break;
      case LayoutMode.hostCenter:
        config.rowSpacing = 5;
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 3,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
      case LayoutMode.fourPeoples:
        config.rowConfigs = [
          ZegoLiveAudioRoomLayoutRowConfig(
            count: 4,
            alignment: ZegoLiveAudioRoomLayoutAlignment.spaceBetween,
          ),
        ];
        break;
    }
    return config;
  }

  void onMemberListMoreButtonPressed(ZegoUIKitUser user) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff111014),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      isDismissible: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        const textStyle = TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
        final listMenu = widget.isHost
            ? [
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();

                    ZegoUIKit().removeUserFromRoom(
                      [user.id],
                    ).then((result) {
                      debugPrint('kick out result:$result');
                    });
                  },
                  child: Text(
                    'Kick Out ${user.name}',
                    style: textStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();

                    liveController
                        .inviteAudienceToTakeSeat(user.id)
                        .then((result) {
                      debugPrint('invite audience to take seat result:$result');
                    });
                  },
                  child: Text(
                    'Invite ${user.name} to take seat',
                    style: textStyle,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: textStyle,
                  ),
                ),
              ]
            : [];
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 50),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listMenu.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 60,
                  child: Center(child: listMenu[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

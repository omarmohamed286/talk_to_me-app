import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_to_me/core/models/user_model.dart';
import 'package:talk_to_me/core/utils/custom_snack_bar.dart';
import 'package:talk_to_me/features/home/data/models/room_model.dart';
import 'package:talk_to_me/features/home/presentation/view_models/room_cubit/room_cubit.dart';
import 'package:talk_to_me/features/home/presentation/view_models/user_data_cubit/user_data_cubit.dart';
import '../../../../core/utils/check_creating_room_capability.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../../core/utils/socket_service.dart';
import 'widgets/bottom_sheet_body.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/rooms_list_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<RoomCubit>(context).getRooms();
    BlocProvider.of<UserDataCubit>(context).getUser();
    getIt<SocketService>().recieveEvent('roomCreated', (data) {
      BlocProvider.of<RoomCubit>(context).getRooms();
    });
    getIt<SocketService>().recieveEvent('roomDeleted', (data) {
      BlocProvider.of<RoomCubit>(context).getRooms();
    });
    super.initState();
  }

  UserModel? currentUser;
  List<RoomModel>? rooms;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: BlocBuilder<UserDataCubit, UserDataState>(
              builder: (context, state) {
                if (state is GetUserDataSuccess) {
                  currentUser =
                      BlocProvider.of<UserDataCubit>(context).currentUser;
                }
                return state is GetUserDataLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          bool ableToCreateRoom =
                              checkCreatingRoomCapability(rooms ?? []);
                          if (!ableToCreateRoom) {
                            showErrorSnackBar(
                                context: context,
                                content:
                                    'You have to wait at least 2 minutes to create a new room');
                          } else {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return BottomSheetBody(
                                    currentUser: currentUser,
                                    );
                              },
                            );
                          }
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text('Create a new room')
                          ],
                        ));
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          BlocBuilder<RoomCubit, RoomState>(
            builder: (context, state) {
              rooms = state is GetRoomsSuccess ? state.rooms : [];
              return state is GetRoomsLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 600,
                      width: 600,
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: rooms!.isEmpty
                              ? const Center(
                                  child: Text('There are no rooms now!'))
                              : RoomsListView(
                                  rooms: rooms,
                                  currentUser: currentUser,
                                )),
                    );
            },
          )
        ],
      ),
    );
  }
}

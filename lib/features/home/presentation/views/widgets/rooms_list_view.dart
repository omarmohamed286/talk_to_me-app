import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:talk_to_me/core/models/user_model.dart';
import 'package:talk_to_me/features/home/data/models/room_model.dart';

import '../../../../../live_page.dart';
import '../../view_models/room_cubit/room_cubit.dart';

class RoomsListView extends StatefulWidget {
  const RoomsListView({super.key, required this.rooms, this.currentUser});

  final List<RoomModel>? rooms;

  final UserModel? currentUser;

  @override
  State<RoomsListView> createState() => _RoomsListViewState();
}

class _RoomsListViewState extends State<RoomsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.rooms!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LivePage(
                          isHost: widget.rooms![index].host.id ==
                                  widget.currentUser?.id
                              ? true
                              : false,
                          user: widget.currentUser!,
                          room: widget.rooms![index],
                        )));
            BlocProvider.of<RoomCubit>(context)
                .addParticipant(roomId: widget.rooms![index].id);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.network(
                        widget.rooms![index].host.image,
                        width: 100,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(widget.rooms![index].host.username),
                    ],
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          widget.rooms![index].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.rooms![index].language,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.rooms![index].languageLevel,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Lottie.asset(
                      height: 30, width: 30, 'assets/lotties/live.json'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

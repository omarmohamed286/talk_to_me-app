import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_to_me/constants.dart';
import 'package:talk_to_me/core/utils/service_locator.dart';
import 'package:talk_to_me/core/utils/socket_service.dart';
import 'package:talk_to_me/core/widgets/custom_button.dart';
import 'package:talk_to_me/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:talk_to_me/features/home/data/repos/home_repo_impl.dart';
import 'package:talk_to_me/features/home/presentation/view_models/room_cubit/room_cubit.dart';
import 'package:talk_to_me/live_page.dart';
import '../../../../../core/models/user_model.dart';
import 'custom_drop_down_button.dart';

class BottomSheetBody extends StatefulWidget {
  const BottomSheetBody({super.key, this.currentUser});

  final UserModel? currentUser;

  @override
  State<BottomSheetBody> createState() => _BottomSheetBodyState();
}

class _BottomSheetBodyState extends State<BottomSheetBody> {
  String? title, language, languageLevel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomCubit(getIt<HomeRepoImpl>()),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomTextFormField(
              labelText: 'Title',
              textInputAction: TextInputAction.done,
              maxLength: 20,
              onChanged: (value) {
                title = value;
              },
            ),
          ),
          const SizedBox(height: 50),
          CustomDropDownButton(
            value: language,
            hint: 'Language',
            items: kLanguages,
            onChanged: (value) {
              language = value;
              setState(() {});
            },
          ),
          const SizedBox(height: 30),
          CustomDropDownButton(
              value: languageLevel,
              hint: 'Language Level',
              items: kLevels,
              onChanged: (value) {
                languageLevel = value;
                setState(() {});
              }),
          const SizedBox(height: 30),
          BlocConsumer<RoomCubit, RoomState>(
            listener: (context, state) {
              if (state is RoomSuccess) {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LivePage(
                              isHost: true,
                              user: widget.currentUser!,
                              room: state.room,
                            )));
                getIt<SocketService>().sendEvent('createRoom');
              }
            },
            builder: (context, state) {
              return state is RoomLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Create',
                      onPressed: () {
                        if (title != null &&
                            language != null &&
                            languageLevel != null) {
                          BlocProvider.of<RoomCubit>(context).createRoom(
                              title: title!,
                              language: language!,
                              languageLevel: languageLevel!,
                              hostId: widget.currentUser!.id);
                        }
                      },
                    );
            },
          )
        ],
      ),
    );
  }
}

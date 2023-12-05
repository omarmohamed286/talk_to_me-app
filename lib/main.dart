import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talk_to_me/constants.dart';
import 'package:talk_to_me/core/utils/app_routes.dart';
import 'package:talk_to_me/core/utils/cache_service.dart';
import 'package:talk_to_me/core/utils/service_locator.dart';
import 'package:talk_to_me/core/utils/socket_service.dart';
import 'package:talk_to_me/features/auth/data/repos/auth_repo_impl.dart';
import 'package:talk_to_me/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:talk_to_me/features/auth/presentation/views/login_view.dart';
import 'package:talk_to_me/features/home/presentation/view_models/room_cubit/room_cubit.dart';
import 'package:talk_to_me/features/home/presentation/view_models/user_data_cubit/user_data_cubit.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';
import 'features/home/data/repos/home_repo_impl.dart';
import 'features/home/data/repos/user_data_repo/user_data_repo_impl.dart';
import 'features/home/presentation/views/home_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final navigatorKey = GlobalKey<NavigatorState>();
  setupServiceLocator();
  await getUserToken();
  getIt<SocketService>().startConnection();
  await dotenv.load(fileName: "lib/.env");
  ZegoUIKit().initLog().then((value) {
    runApp(MyApp(
      navigatorKey: navigatorKey,
    ));
  });
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RoomCubit(getIt<HomeRepoImpl>()),
        ),
        BlocProvider(
          create: (context) => UserDataCubit(getIt<UserDataRepoImpl>()),
        )
      ],
      child: MaterialApp(
        title: 'Talk To Me',
        debugShowCheckedModeBanner: false,
        home: token?.isEmpty ?? true
            ? BlocProvider(
                create: (context) => AuthCubit(getIt<AuthRepoImpl>()),
                child: const LoginView(),
              )
            : const HomeView(),
        routes: AppRoutes.routes,
        navigatorKey: widget.navigatorKey,
        builder: (BuildContext context, Widget? child) {
          return Stack(
            children: [
              child!,
              ZegoUIKitPrebuiltLiveAudioRoomMiniOverlayPage(
                contextQuery: () {
                  return widget.navigatorKey.currentState!.context;
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

String? token;

Future<void> getUserToken() async {
  token = await getIt<CacheService>().getData(key: kTokenKey);
}

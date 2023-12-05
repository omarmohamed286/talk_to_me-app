import 'package:flutter/material.dart';
import 'package:talk_to_me/constants.dart';

import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/cache_service.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/widgets/custom_dialog.dart';


PreferredSizeWidget? homeAppBar(BuildContext context) => AppBar(
      title: const Text('Home'),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              customDialog(
                context: context,
                title: 'Are you sure?',
                desc: 'Are you sure you want to logout?',
                onOk: () {
                  Navigator.pushNamed(context, AppRoutes.loginView);
                  getIt<CacheService>().deleteData(key: kTokenKey);
                },
              ).show();
            },
            icon: const Icon(Icons.logout))
      ],
    );

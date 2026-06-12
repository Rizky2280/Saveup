import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'core/theme/theme.dart';

class SaveUpApp extends StatelessWidget {
  const SaveUpApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SaveUp',
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}

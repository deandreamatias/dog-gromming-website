import 'package:dog_gromming_website/di/di.dart';
import 'package:dog_gromming_website/env/env.dart';
import 'package:dog_gromming_website/ui/navigation/main_navigator.dart';
import 'package:dog_gromming_website/ui/styles/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: getIt.get<Env>().appName,
      theme: themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: getIt<MainNavigator>().router,
    );
  }
}
